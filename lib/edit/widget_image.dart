import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageView extends StatelessWidget {
  final path;

  ImageView(this.path);

  @override
  Widget build(BuildContext context) {
    if (path.contains(r'/')) {
      return Image.file(File(path), fit: BoxFit.cover, width: double.infinity);
    } else {
      if (path != 'INACESSÍVEL' && path.isNotEmpty && path != null) {
        return Image.asset(
          'assets/melville/$path.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
        );
      } else {
        return Icon(Icons.camera_alt,size: 250,);
      }
    }
  }
}

class ImageViewPicker extends StatelessWidget {
  final String path;
  final ValueChanged pathNewImage;

  const ImageViewPicker({Key key, this.path, this.pathNewImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      height: 300,
      child: GestureDetector(
        child: ImageView(path),
        onTap: () async {
          var image = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 1024,maxWidth: 1024);
          pathNewImage(image.path);
        },
      ),
    );
  }
}
