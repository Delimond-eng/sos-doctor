import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_docteur/constants/style.dart';

class EditableField extends StatefulWidget {
  final String title;
  final Function onEdit;
  final TextEditingController controller;
  const EditableField({
    Key key,
    this.title,
    this.onEdit,
    this.controller,
  }) : super(key: key);

  @override
  State<EditableField> createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  bool hasEdited = false;
  FocusNode inputNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border(bottom: BorderSide(color: primaryColor, width: .5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(widget.title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  controller: widget.controller,
                  focusNode: inputNode,
                  autofocus: hasEdited ? true : false,
                  readOnly: hasEdited ? false : true,
                  style: GoogleFonts.lato(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                    hintText: "Saisir une valeur...",
                    hintStyle: GoogleFonts.lato(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              if (!hasEdited) ...[
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(inputNode);
                    setState(() {
                      hasEdited = true;
                    });
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 10.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.pencil, color: Colors.white),
                    ),
                  ),
                )
              ] else ...[
                GestureDetector(
                  onTap: () {
                    widget.onEdit();
                    Future.delayed(const Duration(milliseconds: 500));
                    setState(() {
                      hasEdited = false;
                    });
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          blurRadius: 10.0,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                )
              ]
            ],
          ),
        ],
      ),
    );
  }
}
