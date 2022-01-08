import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key key, this.items, this.onChanged, this.selectedValue, this.hintText})
      : super(key: key);
  final List<dynamic> items;
  final dynamic selectedValue;
  final Function(dynamic value) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.grey.withOpacity(.3),
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: DropdownButton<dynamic>(
        menuMaxHeight: 300,
        dropdownColor: Colors.white,
        alignment: Alignment.centerRight,
        borderRadius: BorderRadius.circular(15.0),
        style: GoogleFonts.lato(color: Colors.black),
        value: selectedValue,
        underline: SizedBox(),
        hint: Text(
          " $hintText",
          style: GoogleFonts.mulish(
              color: Colors.grey[600],
              fontSize: 15.0,
              fontStyle: FontStyle.italic),
        ),
        isExpanded: true,
        items: items.map((e) {
          return DropdownMenuItem<String>(
              value: e,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "$e",
                  style: GoogleFonts.lato(fontWeight: FontWeight.w400),
                ),
              ));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
