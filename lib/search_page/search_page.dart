import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:superhero/constants.dart';
import 'package:superhero/data/data.dart';
import 'package:superhero/home_screen/widgets/superhero_card.dart';
import 'package:superhero/models/superhero_model.dart';
import 'package:superhero/superheroinfo/superhero_info.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => new SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  List results = [];
  var rows = [];
  String query = '';
  TextEditingController tc = TextEditingController();

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
    rows = superheros;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Search",
                        style: heading.copyWith(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 12, 0, 12),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: Offset(0, 5),
                              blurRadius: 12.0,
                              spreadRadius: 0,
                            )
                          ]),
                      child: TextField(
                        controller: tc,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Start typing...',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) {
                          setState(() {
                            query = v;
                            setResults(query);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    query.isEmpty
                        ? Container(
                            child: Hive.box('LastSearch').length != 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Text(
                                          "Recents",
                                          style: normalText.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          child: Text("CLEAR"),
                                          onPressed: () {
                                            final box = Hive.box('LastSearch');
                                            print(box.length);
                                            for (var i = 1;
                                                i < box.length;
                                                i++) {
                                              box.deleteAt(i);
                                            }
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchPage()));
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Container())
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Search Results",
                              style: normalText.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                    SizedBox(height: 10),
                    Container(
                      color: Colors.white,
                      child: query.isEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: Hive.box('LastSearch').length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final favorite =
                                    Hive.box('LastSearch').getAt(index);
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 16, 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            offset: Offset(0, 5),
                                            blurRadius: 12.0,
                                            spreadRadius: 0,
                                          )
                                        ]),
                                    child: ListTile(
                                      title: Text(favorite['name']),
                                      subtitle: Text(
                                          favorite['biography']['fullname']),
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
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
                                              child: SuperHeroInfo(
                                                model: SuperheroModel.fromJson(
                                                    favorite),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  results.length > 20 ? 20 : results.length,
                              itemBuilder: (con, ind) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 16, 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.6),
                                            offset: Offset(0, 5),
                                            blurRadius: 12.0,
                                            spreadRadius: 0,
                                          )
                                        ]),
                                    child: ListTile(
                                      title: Text(results[ind]['name']),
                                      subtitle: Text(results[ind]['biography']
                                          ['fullname']),
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        final box = Hive.box('LastSearch');
                                        box.add(results[ind]);
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
                                              child: SuperHeroInfo(
                                                model: SuperheroModel.fromJson(
                                                    results[ind]),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setResults(String query) {
    results = rows
        .where((elem) =>
            elem['name'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
