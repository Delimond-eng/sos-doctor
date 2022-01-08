import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_docteur/constants/style.dart';

class AuthInputText extends StatefulWidget {
  final inputController;
  final String hintText;
  final IconData icon;
  final bool isPassWord;
  final TextInputType keyType;
  final bool hasReadOnly;

  AuthInputText({
    Key key,
    this.inputController,
    this.hintText,
    this.icon,
    this.isPassWord = false,
    this.keyType,
    this.hasReadOnly = false,
  }) : super(key: key);

  @override
  _AuthInputTextState createState() => _AuthInputTextState();
}

class _AuthInputTextState extends State<AuthInputText> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: widget.isPassWord == false
          ? TextField(
              controller: widget.inputController,
              style: const TextStyle(fontSize: 14.0),
              keyboardType: widget.keyType ?? TextInputType.text,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.black54),
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
            )
          : TextField(
              controller: widget.inputController,
              keyboardType: widget.keyType ?? TextInputType.text,
              obscureText: _isObscure,
              readOnly: widget.hasReadOnly,
              style: const TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
                hintStyle: const TextStyle(color: Colors.black54),
                icon: Container(
                    height: 50.0,
                    width: 50.0,
                    child: Icon(widget.icon,
                        size: 20.0, color: primaryColor.withOpacity(.7))),
                border: InputBorder.none,
                counterText: '',
                suffixIcon: (!widget.hasReadOnly)
                    ? IconButton(
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
                      )
                    : null,
              ),
            ),
    );
  }
}
