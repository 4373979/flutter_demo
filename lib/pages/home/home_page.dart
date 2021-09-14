import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {

  UserInfo? userInfo;

  HomePage({Key? key,required this.userInfo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userInfo!);
}

class _HomePageState extends State<HomePage> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  UserInfo? userInfo;

  String _contactText = '';

  _HomePageState(this.userInfo);

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  @override
  void initState() {
    super.initState();
    print(userInfo!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 800,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ListTile(
              leading: Image.network(userInfo!.photoURL.toString()),
              title: Text(userInfo!.displayName ?? ''),
              subtitle: Text(userInfo!.email.toString()),
            ),
            Text("Signed in successfully."),
            Text('id:${userInfo!.uid}'),
            Text('email:${userInfo!.email}'),
            Text('name:${userInfo!.displayName}'),
            ElevatedButton(
              child: const Text('SIGN OUT'),
              onPressed:() {
                _handleSignOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => new LoginPage())
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
