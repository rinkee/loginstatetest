import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlelogin_firebase/App.dart';

import '../main.dart';
import 'HomePage.dart';

final _formKey = GlobalKey<FormState>();
DateTime _date = DateTime.now();
TextEditingController nameController = TextEditingController();

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Enter User NickName",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter User Name';
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
                color: Colors.lightBlue,
                onPressed: () {
                  final gCurrentUser = GoogleSignIn().currentUser;
                  final user = FirebaseAuth.instance.currentUser;
                  addUserInFirestore();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyApp()));
                  Get.offAll(App());
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> addUserInFirestore() async {
  final gCurrentUser = GoogleSignIn().currentUser;
  final user = FirebaseAuth.instance.currentUser;
  final doc1 = FirebaseFirestore.instance.collection('user').doc(user.uid);
  DocumentSnapshot doc = await doc1.get();
  // .get();
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  if (!doc.exists) {
    doc1
        .set({
          'display_name': user.displayName,
          'nick_name': nameController.text,
          'photoURL': user.photoURL,
          'email': user.email,
          'create_data': _date
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
