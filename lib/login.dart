import 'package:crud_notes/note_ui_here/front_page.dart';
import 'package:crud_notes/services/auth.dart';
import 'package:crud_notes/services/firestore_db.dart';
import 'package:crud_notes/services/login_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google, onPressed: ()async{
              await signInWithGoogle();
              final User? currentUser =  await _auth.currentUser;
              LocalDataSaver.saveLoginData(true);
              LocalDataSaver.saveImg(currentUser!.photoURL.toString());
              LocalDataSaver.saveMail(currentUser.email.toString());
              LocalDataSaver.saveName(currentUser.displayName.toString());
              LocalDataSaver.saveSyncSet(false);
              await FireDB().getAllStoredNotes();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FrontPage()));
            })
          ],
        ),
      ),
    );
  }
}
