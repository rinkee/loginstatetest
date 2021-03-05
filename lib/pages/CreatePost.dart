import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/App.dart';
import 'package:googlelogin_firebase/controller/my_page_controller.dart';
import 'package:googlelogin_firebase/main.dart';
import 'package:googlelogin_firebase/pages/HomePage.dart';

import 'dart:async';
import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';

// TextEditingController contentController = TextEditingController();
final _contentText = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool _validate = false;

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '새 게시물',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(color: Colors.black),
        elevation: 1,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FlatButton(
                onPressed: () {},
                child: Text('Add Post'),
              ),
              Text(''),
              TextFormField(
                controller: _contentText,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter a message",
                  border: InputBorder.none,
                  fillColor: Colors.grey[200],
                  filled: true,
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              RaisedButton(
                color: Colors.lightBlue,
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  if (_formKey.currentState.validate()) {
                    addPostInFirestore();
                    // If the form is valid, display a Snackbar.
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Processing Data')));
                    Get.offAll(MyPageController(),
                        transition: Transition.rightToLeft);
                    _contentText.clear();
                  }

                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => App()));
                },
                child: Text('Submit'),
              ),
              Center(child: Text('Error: $_error')),
              RaisedButton(
                child: Text("Pick images"),
                onPressed: loadAssets,
              ),
              Expanded(
                child: buildGridView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void uploadImages() {
  //   for (var imageFile in images) {
  //     postImage(imageFile).then((downloadUrl) {
  //       imageUrls.add(downloadUrl.toString());
  //       if (imageUrls.length == images.length) {
  //         String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
  //         Firestore.instance
  //             .collection('images')
  //             .document(documnetID)
  //             .setData({'urls': imageUrls}).then((_) {
  //           SnackBar snackbar =
  //               SnackBar(content: Text('Uploaded Successfully'));
  //           widget.globalKey.currentState.showSnackBar(snackbar);
  //           setState(() {
  //             images = [];
  //             imageUrls = [];
  //           });
  //         });
  //       }
  //     }).catchError((err) {
  //       print(err);
  //     });
  //   }
  // }
}

Widget buildTextField() {
  final maxLines = 5;

  return Container(
    margin: EdgeInsets.all(12),
    height: maxLines * 24.0,
    child: TextField(
      controller: _contentText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: "Enter a message",
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        filled: true,
        errorText: _validate ? 'Value Can\'t Be Empty' : null,
      ),
    ),
  );
}

Future<void> addPostInFirestore() async {
  final gCurrentUser = GoogleSignIn().currentUser;
  final user = FirebaseAuth.instance.currentUser;
  final doc1 = FirebaseFirestore.instance
      .collection('post')
      .doc(user.uid)
      .collection('uploadPost')
      .doc();
  DocumentSnapshot doc = await doc1.get();
  // .get();
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('post');
  doc1
      .set({
        'content': _contentText.text,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
