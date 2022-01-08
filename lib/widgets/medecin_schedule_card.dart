import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';

class MedecinScheduleCard extends StatelessWidget {
  final Function onTap;

  const MedecinScheduleCard({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 130.0,
            width: _size.width,
            margin: const EdgeInsets.only(bottom: 20.0),
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/shapes/bg1.png"),
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.6),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    offset: const Offset(0, 3),
                    blurRadius: 12.0,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gaston delimond",
                          style: style1(
                              fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                        Container(
                          height: 50.0,
                          width: 50.0,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.cyan.withOpacity(.5),
                                  primaryColor.withOpacity(.5)
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(.2),
                                    blurRadius: 12.0,
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Center(
                              child: Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                CupertinoIcons.calendar,
                                size: 15.0,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Text("20/11/2021")
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                CupertinoIcons.time,
                                size: 15.0,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Text("13:00")
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Badge(
                            badgeColor: Colors.green,
                            badgeContent: const Text(""),
                            child: const Text("Complète"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          right: 0,
          child: Container(
            height: 30.0,
            child: RaisedButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              color: Colors.grey[800],
              child: const Icon(
                Icons.clear,
                size: 16,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}
