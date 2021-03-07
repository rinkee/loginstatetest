// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
//
// class TestPage extends StatefulWidget {
//   @override
//   _TestPageState createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   List<Asset> images = List<Asset>();
//   String popop = mockString(50);
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   }
//
//   Future saveImage(Asset asset) async {
//     String fileName = popop;
//     ByteData byteData = await asset.requestOriginal();
//     List<int> imageData = byteData.buffer.asUint8List();
//      ref = FirebaseStorage.instance.ref().child(fileName);
//     uploadTask = ref.putData(imageData);
//
//     return await uploadTask.onComplete.ref.getDownloadURL();
//   }
//
//   Future<void> loadAssets() async {
//     List<Asset> resultList = List<Asset>();
//     try {
//       resultList = await MultiImagePicker.pickImages(
//           maxImages: 300,
//           enableCamera: true,
//           selectedAssets: images,
//           cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//           materialOptions: MaterialOptions(
//             actionBarColor: "#abcdef",
//             actionBarTitle: "Example App",
//             allViewTitle: "All Photos",
//             selectCircleStrokeColor: "#000000",
//           ));
//     }
//   }
//   if (!mounted) return;
//
//   setState(() {
//   images = resultList;
//   _error = error;
//   });
// }
//
// @override
// Widget build(BuildContext context) {
//   return new MaterialApp(
//     home: new Scaffold(
//       appBar: new AppBar(
//         title: const Text('Getting pics'),
//       ),
//       body: Column(
//         children: <Widget>[
//           RaisedButton(
//             child: Text("Pick images"),
//             onPressed: loadAssets,
//           ),
//           RaisedButton(
//             child: Text("Save Image"),
//             onPressed: () => saveImage,
//           ),
//           Expanded(
//             child: buildGridView(),
//           )
//         ],
//       ),
//     ),
//   );
// }
// }
