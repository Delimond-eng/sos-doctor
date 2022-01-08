import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

List<String> langues = [
  "Sélectionnez une langue",
  "langue",
  "Français",
  "Anglais",
  "Lingala",
  "Swahili",
  "Kikongo",
  "Tshiluba",
  "Espagnol",
  "Portugais",
  "Italien"
];

class Specialities {
  String title;
  String icon;
  bool isActive = false;
  Specialities({this.title, this.icon});
}

Future<PickedFile> takePhoto({ImageSource source}) async {
  final ImagePicker _picker = ImagePicker();
  // ignore: deprecated_member_use
  final pickedFile = await _picker.getImage(
    source: source,
  );

  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}

void showScrollableSheet(context, {List<Widget> childrens}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.8,
        builder: (_, controller) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Stack(
              // ignore: deprecated_member_use
              overflow: Overflow.visible,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.zero),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    controller: controller,
                    children: childrens,
                  ),
                ),
                Positioned(
                  top: -25,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red[200],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.4),
                              blurRadius: 12.0,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.clear,
                          color: Colors.red[800],
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
