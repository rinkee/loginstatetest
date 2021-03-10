import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googlelogin_firebase/provider/SignInProvider.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //로그인 프로바이더 가져오기
    final provider = Provider.of<SignInProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final nickname = FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot ds) {
      ds.data();
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('MyPage'),
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL),
                radius: 60.0,
              ),
              Text(user.displayName),
              Text(user.uid),
              Expanded(child: GetUserName(user.uid)),
              FlatButton(
                onPressed: () {
                  provider.logout();
                },
                child: Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("${data['nick_name']}");
        }

        return Text("loading");
      },
    );
  }
}
