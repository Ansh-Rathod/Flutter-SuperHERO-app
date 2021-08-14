import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:superhero/constants.dart';

import 'package:superhero/models/superhero_model.dart';

class SuperHeroInfo extends StatefulWidget {
  final SuperheroModel model;
  const SuperHeroInfo({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _SuperHeroInfoState createState() => _SuperHeroInfoState();
}

class _SuperHeroInfoState extends State<SuperHeroInfo>
    with TickerProviderStateMixin {
  bool isFavorited = false;

  @override
  void initState() {
    getColor();

    super.initState();
  }

  Color backcolor = Colors.white;
  Color textcolor = Colors.black;
  getColor() async {
    final box = await Hive.openBox('Favorites');
    final info = box.get(widget.model.id);
    if (info != null) {
      setState(() {
        isFavorited = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: backcolor,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    widget.model.image!.url,
                  ),
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    backcolor.withOpacity(0.8),
                    backcolor.withOpacity(0.8),
                    backcolor,
                    backcolor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                height: 85,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: textcolor,
                          ),
                        ),
                        Text(
                          widget.model.name,
                          style: heading.copyWith(
                            color: textcolor,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final box = await Hive.openBox('Favorites');

                            if (!isFavorited) {
                              box.put(widget.model.id, widget.model.toJson());
                              final info = box.get(widget.model.id);
                              setState(() {
                                isFavorited = true;
                              });
                            } else {
                              box.delete(widget.model.id);
                              setState(() {
                                isFavorited = false;
                              });
                            }
                          },
                          icon: Icon(
                            !isFavorited
                                ? Icons.favorite_outline
                                : Icons.favorite,
                            color: !isFavorited ? textcolor : Colors.red,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 85,
              right: 0,
              left: 0,
              height: MediaQuery.of(context).size.height - 85,
              child: Container(
                height: MediaQuery.of(context).size.height - 85,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Hero(
                        tag: widget.model.image!.url,
                        child: CachedNetworkImage(
                          imageUrl: widget.model.image!.url,
                          height: 300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.model.biography!.fullname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: textcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      if (widget.model.work!.occupation != "-")
                        Text(
                          widget.model.work!.occupation,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: normalText.copyWith(color: textcolor),
                          textAlign: TextAlign.center,
                        )
                      else if (widget.model.work!.base != "-")
                        Text(
                          widget.model.work!.base,
                          maxLines: 5,
                          style: normalText.copyWith(color: textcolor),
                          textAlign: TextAlign.center,
                        )
                      else if (widget.model.work!.occupation == "-" &&
                          widget.model.work!.base == "-")
                        Text(
                          widget.model.biography!.alterEgos,
                          maxLines: 5,
                          style: normalText.copyWith(color: textcolor),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 30),
                      if (widget.model.connections!.relatives != "-" &&
                          widget.model.connections!.group != "-")
                        Text(
                          "Conections",
                          style: TextStyle(
                            fontSize: 18,
                            color: textcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 15),
                      if (widget.model.connections!.relatives != "-")
                        Text(
                          widget.model.connections!.relatives,
                          style: TextStyle(fontSize: 18, color: textcolor),
                        ),
                      if (widget.model.connections!.relatives != "-")
                        SizedBox(height: 15),
                      if (widget.model.connections!.group != "-")
                        Text(
                          widget.model.connections!.group,
                          style: TextStyle(fontSize: 18, color: textcolor),
                        ),
                      if (widget.model.connections!.group != "-")
                        SizedBox(height: 30),
                      if (widget.model.biography!.aliases.first != "-")
                        Text(
                          "Aliases",
                          style: TextStyle(
                            fontSize: 18,
                            color: textcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (widget.model.biography!.aliases.first != "-")
                        SizedBox(height: 15),
                      if (widget.model.biography!.aliases.first != "-")
                        RichText(
                          text: TextSpan(
                            children: [
                              ...widget.model.biography!.aliases
                                  .map(
                                    (all) => TextSpan(
                                      text: all + ", ",
                                      style: TextStyle(
                                          fontSize: 18, color: textcolor),
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        ),
                      if (widget.model.biography!.aliases.first != "-")
                        SizedBox(height: 30),
                      Text(
                        "Place of Birth",
                        style: TextStyle(
                          fontSize: 18,
                          color: textcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.model.biography!.place,
                        style: TextStyle(fontSize: 18, color: textcolor),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "First-appearance",
                        style: TextStyle(
                          fontSize: 18,
                          color: textcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.model.biography!.first,
                        style: TextStyle(fontSize: 18, color: textcolor),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Publisher",
                        style: TextStyle(
                          fontSize: 18,
                          color: textcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.model.biography!.publisher,
                        style: TextStyle(fontSize: 18, color: textcolor),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
