

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';

class SearchInput extends StatelessWidget {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1.20),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          controller: _controller,
          style: const TextStyle(fontSize: 14.0),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 10, bottom: 12),
            hintText: "Recherche",
            hintStyle: const TextStyle(color: Colors.black54),
            icon: Icon(
              CupertinoIcons.search,
              color: primaryColor,
              size: 15.0,
            ),
            suffixIcon: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.cyan[50],
                shape: BoxShape.circle
              ),
              child: Icon(
                Icons.compare_arrows,
                size: 15.0,
                color: primaryColor,
              ),
            ),
            border: InputBorder.none,
            counterText: '',
          ),
        ));
  }
}