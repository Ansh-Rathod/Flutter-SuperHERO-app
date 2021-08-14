import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/data/data.dart';
import 'package:superhero/data/popular.dart';
import 'package:superhero/home_screen/widgets/superhero_card.dart';
import 'package:superhero/models/superhero_model.dart';
import 'package:superhero/search_page/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final List<SuperheroModel> list =
      superheros.map((e) => SuperheroModel.fromJson(e)).toList();
  final List<SuperheroModel> popularlist =
      popular.map((e) => SuperheroModel.fromJson(e)).toList();
  PageController controller = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: PreferredSize(
            child: SafeArea(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SUPERHERODB", style: heading),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    reverseTransitionDuration:
                                        Duration(milliseconds: 500),
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: SearchPage(),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.search))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                controller.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              });
                              setState(() {
                                index = 0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? Colors.red
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Popular",
                                  style: TextStyle(
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              controller.animateToPage(
                                1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );

                              setState(() {
                                index = 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: index == 1
                                    ? Colors.red
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "A TO Z",
                                  style: TextStyle(
                                    color: index == 1
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              controller.animateToPage(
                                2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              setState(() {
                                index = 2;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: index == 2
                                    ? Colors.red
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Favorites",
                                  style: TextStyle(
                                    color: index == 2
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(144)),
        backgroundColor: Colors.white,
        body: PageView(
          onPageChanged: (int pageIndex) {
            setState(() {
              index = pageIndex;
            });
          },
          controller: controller,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: popularlist.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final superhero = popularlist[index];
                return SuperHeroCard(superHero: superhero);
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final superhero = list[index];
                return SuperHeroCard(superHero: superhero);
              },
            ),
            Hive.box('Favorites').length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: Hive.box('Favorites').length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final favorite = Hive.box('Favorites').getAt(index);
                      return SuperHeroCard(
                        superHero: SuperheroModel.fromJson(favorite),
                      );
                    },
                  )
                : Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border,
                              size: 85, color: Colors.grey),
                          SizedBox(height: 20),
                          Text("Your Favorite List is Empty.")
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
