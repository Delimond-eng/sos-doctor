import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'index.dart';

class DataConnectionScreen extends StatefulWidget {
  DataConnectionScreen({Key key}) : super(key: key);

  @override
  _DataConnectionScreenState createState() => _DataConnectionScreenState();
}

class _DataConnectionScreenState extends State<DataConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/lotties/61169-no-wifi-connection-error.json",
                fit: BoxFit.scaleDown,
                height: 120.0,
                width: 120.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Vous devez activer les données mobiles ou vous connectez au WIFI !",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text(
                  "Fermer",
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                color: Colors.pink,
                padding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onPressed: () {
                  exit(0);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
