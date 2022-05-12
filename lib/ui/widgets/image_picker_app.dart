import 'dart:io';

import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    Key? key,
    this.imagePickFn,
  }) : super(key: key);
  final void Function(File pickedImage)? imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _imageFileCamera;
  final _picker = ImagePicker();
  set _imageFile(XFile? value) {
    _imageFileCamera = value == null ? null : value;
  }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(
      source: imageSource,
      imageQuality: 100,
    );

    if (!mounted) return; setState(() {
      if (pickedFile == null) {
      } else {
        _imageFile = pickedFile;
        widget.imagePickFn!(File(_imageFileCamera!.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
          backgroundImage: _imageFileCamera != null
              ? FileImage(
                  File(_imageFileCamera!.path),
                )
              : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            appButttonWithoutAnimation(
              context,
              Icons.ac_unit,
              'Take Image',
              () async {
                getImage(ImageSource.camera);
              },
            ),
            appButttonWithoutAnimation(
              context,
              Icons.ac_unit,
              'Pick Image',
              () async {
                getImage(
                  ImageSource.gallery,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
