import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sos_docteur/constants/style.dart';

class StandardInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassWord;
  final TextInputType keyType;
  final double radius, arround;
  final bool withBtn;
  final Function onPressed;

  StandardInput(
      {Key key,
      this.controller,
      this.hintText,
      this.icon,
      this.isPassWord = false,
      this.keyType,
      this.withBtn = false,
      this.onPressed,
      this.radius,
      this.arround});
  @override
  _StandardInputState createState() => _StandardInputState();
}

class _StandardInputState extends State<StandardInput> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: widget.radius == null
            ? BorderRadius.circular(10.0)
            : BorderRadius.circular(widget.radius),
        color: Colors.grey[50],
        border: Border.all(color: primaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: (widget.isPassWord)
          ? TextField(
              controller: widget.controller,
              keyboardType: widget.keyType ?? TextInputType.text,
              obscureText: _isObscure,
              style: const TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
                  hintStyle: const TextStyle(color: Colors.black54),
                  icon: Container(
                    height: 50.0,
                    width: 50.0,
                    child: Icon(
                      CupertinoIcons.lock,
                      size: 20.0,
                      color: primaryColor.withOpacity(.7),
                    ),
                  ),
                  border: InputBorder.none,
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 15,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
            )
          : (widget.keyType == TextInputType.datetime)
              ? TextField(
                  // maxLength: 10,
                  keyboardType: TextInputType.datetime,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: 'JJ / MM / AAAA',
                    hintStyle: const TextStyle(color: Colors.black38),
                    contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                    icon: Container(
                      width: 50.0,
                      height: 50.0,
                      child: Icon(
                        widget.icon,
                        color: primaryColor.withOpacity(.7),
                        size: 20.0,
                      ),
                    ),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  inputFormatters: [
                    // ignore: deprecated_member_use
                    WhitelistingTextInputFormatter(RegExp("[0-9/]")),
                    LengthLimitingTextInputFormatter(10),
                    DateFormatter(),
                  ],
                )
              : TextField(
                  controller: widget.controller,
                  style: const TextStyle(fontSize: 14.0),
                  keyboardType: widget.keyType ?? TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: (!widget.withBtn) ? 10 : 15,
                      bottom: 10,
                    ),
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: Colors.black54),
                    icon: Container(
                      width: 50.0,
                      height: 50.0,
                      child: Icon(
                        widget.icon,
                        color: Colors.cyan,
                        size: 15.0,
                      ),
                    ),
                    suffixIcon: (widget.withBtn)
                        ? Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.checkmark_alt,
                                size: 15.0,
                                color: Colors.white,
                              ),
                              color: primaryColor.withOpacity(.7),
                              onPressed: widget.onPressed,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
    );
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
