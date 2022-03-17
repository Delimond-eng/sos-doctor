import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../index.dart';

class FileUploader extends StatelessWidget {
  final String uploadFile;
  final Function onUpload;
  final Function onCanceled;
  const FileUploader({
    Key key,
    this.uploadFile = "",
    this.onUpload,
    this.onCanceled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: primaryColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.3),
                blurRadius: 12.0,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Container(
            decoration: ((uploadFile.isNotEmpty) && (uploadFile != null))
                ? BoxDecoration(
                    image: DecorationImage(
                        image: MemoryImage(
                          base64Decode(uploadFile),
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        blurRadius: 12.0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  )
                : null,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: onUpload,
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (uploadFile.isEmpty)
                      Text("Certificat",
                          style: GoogleFonts.lato(color: primaryColor)),
                    const SizedBox(height: 10.0),
                    Icon(
                      CupertinoIcons.cloud_upload_fill,
                      color:
                          uploadFile.isEmpty ? primaryColor : Colors.green[700],
                      size: 30.0,
                    ),
                    const SizedBox(height: 5.0),
                    if (uploadFile.isEmpty)
                      Text(
                          "insérez votre certificat en format [JPG, PNG, JPEG]",
                          style: GoogleFonts.lato(
                              color: Colors.grey[600], fontSize: 12.0))
                  ],
                )),
              ),
            ),
          ),
        ),
        if (uploadFile.isNotEmpty)
          Positioned(
            bottom: -10,
            right: 5,
            child: GestureDetector(
              onTap: onCanceled,
              child: Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red[200],
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.4),
                          blurRadius: 12.0,
                          offset: const Offset(0, 3))
                    ]),
                child: Center(
                  child: Icon(
                    CupertinoIcons.minus,
                    color: Colors.red[800],
                    size: 18.0,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}

class TileBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;

  const TileBtn({Key key, this.icon, this.label, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 12.0,
                    offset: Offset(0, 3))
              ]),
          child: Center(
            child: Column(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 30.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  label,
                  style:
                      style1(color: primaryColor, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FieldTitle extends StatelessWidget {
  final String label;

  const FieldTitle({Key key, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: style1(fontWeight: FontWeight.w700, fontSize: 15.0),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final String hintText;
  final String selectedDate;
  final Function showDate;
  final double radius;
  const DatePicker({
    Key key,
    this.hintText,
    this.selectedDate,
    this.showDate,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showDate,
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white30,
          border: Border.all(color: primaryColor, width: 1.0),
          borderRadius: radius == null
              ? BorderRadius.circular(5.0)
              : BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.calendar,
                  color: Colors.black45,
                  size: 15.0,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                if (selectedDate.isEmpty)
                  Text(hintText,
                      style: GoogleFonts.lato(
                          fontSize: 16.0, color: Colors.grey[600]))
                else
                  Text(
                    selectedDate,
                    style:
                        GoogleFonts.lato(color: Colors.black, fontSize: 15.0),
                  ),
              ],
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.blue[900],
            )
          ],
        ),
      ),
    );
  }
}
