import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superhero/models/superhero_model.dart';
import 'package:superhero/superheroinfo/superhero_info.dart';

class SuperHeroCard extends StatefulWidget {
  final SuperheroModel superHero;

  const SuperHeroCard({
    Key? key,
    required this.superHero,
  }) : super(key: key);

  @override
  _SuperHeroCardState createState() => _SuperHeroCardState();
}

class _SuperHeroCardState extends State<SuperHeroCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 30, 0, 2),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              reverseTransitionDuration: Duration(milliseconds: 500),
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  FadeTransition(
                opacity: animation,
                child: SuperHeroInfo(
                  model: widget.superHero,
                ),
              ),
            ),
          );
        },
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
                    offset: Offset(0, 10),
                    blurRadius: 16.0,
                    spreadRadius: 0,
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Hero(
                        tag: widget.superHero.image!.url,
                        child: CachedNetworkImage(
                          // height: 200,
                          width: 150,
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            width: 150,
                            color: Colors.grey,
                            child: Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                          imageUrl: widget.superHero.image!.url,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.superHero.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        if (widget.superHero.biography!.fullname != "")
                          Text(
                            widget.superHero.biography!.fullname,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2),
                          ),
                        if (widget.superHero.biography!.fullname != "")
                          SizedBox(height: 10),
                        if (widget.superHero.work!.occupation != "-")
                          Text(
                            widget.superHero.work!.occupation,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          )
                        else if (widget.superHero.work!.base != "-")
                          Text(
                            widget.superHero.work!.base,
                            maxLines: 5,
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          )
                        else if (widget.superHero.work!.occupation == "-" &&
                            widget.superHero.work!.base == "-")
                          Text(
                            widget.superHero.biography!.alterEgos,
                            maxLines: 5,
                            style: TextStyle(
                              letterSpacing: 1.2,
                            ),
                          ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
