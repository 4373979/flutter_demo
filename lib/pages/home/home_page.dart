import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {

  GoogleSignInAccount? user;

  HomePage({Key? key,required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user!);
}

class _HomePageState extends State<HomePage> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount? user;

  String _contactText = '';

  _HomePageState(GoogleSignInAccount this.user);

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();

  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    setState(() {
      _contactText = user.id;
    });
  }

  @override
  void initState() {
    super.initState();
    print(user!.email);
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
              leading: GoogleUserCircleAvatar(
                identity: user!,
              ),
              title: Text(user!.displayName ?? ''),
              subtitle: Text(user!.email),
            ),
            Text("Signed in successfully."),
            Text('id:${user!.id}'),
            Text('email:${user!.email}'),
            Text('name:${user!.displayName}'),
            ElevatedButton(
              child: const Text('SIGN OUT'),
              onPressed:() {
                _handleSignOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => new LoginPage())
                );
              }
            ),
            ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () => _handleGetContact(user!),
            ),
          ],
        ),
      ),
    );
  }
}
