import 'dart:typed_data';

import 'package:image/image.dart' as Img;

Future<Uint8List> removeWhiteBackground(Uint8List bytes) async {
  Img.Image image = Img.decodeImage(bytes);
  Img.Image transparentImage = await colorTransparent(image, 255, 255, 255);
  var newPng = Img.encodePng(transparentImage);
  return newPng;
}

Future<Img.Image> colorTransparent(
    Img.Image src, int red, int green, int blue) async {
  var pixels = src.getBytes();
  for (int i = 0, len = pixels.length; i < len; i += 4) {
    if (pixels[i] == red && pixels[i + 1] == green && pixels[i + 2] == blue) {
      pixels[i + 3] = 0;
    }
  }
  return src;
}
