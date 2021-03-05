import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Test upload image'),
              (imageUrl != null)
                  ? Image.network(imageUrl)
                  : Placeholder(
                      fallbackHeight: 200.0,
                      fallbackWidth: double.infinity,
                    ),
              RaisedButton(
                child: Text('Upload Image'),
                color: Colors.lightBlueAccent,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    final _picker = ImagePicker();
    PickedFile image;

    // 퍼미션 확인
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // 이미지 선택
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if ()
    } else {
      print('Grant Permissions and try again');
    }



    // 업로드 파이어스토리지
  }
}
