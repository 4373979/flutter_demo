import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login/login.dart';
import 'package:flutter_demo/routes/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: routes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}


// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:convert' show json;
//
// import 'package:firebase_auth/firebase_auth.dart';
// import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// FirebaseAuth _auth = FirebaseAuth.instance;
//
// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '1:491018062836:android:edcb018a1e1af82077c7a1',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );
//
//
//
// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Google Sign In',
//       home: SignInDemo(),
//     ),
//   );
// }
//
// class SignInDemo extends StatefulWidget {
//   @override
//   State createState() => SignInDemoState();
// }
//
// class SignInDemoState extends State<SignInDemo> {
//   GoogleSignInAccount? _currentUser;
//   String _contactText = '';
//   String idToken = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact(_currentUser!);
//       }
//     });
//     _googleSignIn.signInSilently();
//   }
//
//   Future<void> _handleGetContact(GoogleSignInAccount user) async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       Uri.parse('https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names'),
//       headers: await user.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String? namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }
//
//   String? _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic>? connections = data['connections'];
//     final Map<String, dynamic>? contact = connections?.firstWhere(
//           (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic>? name = contact['names'].firstWhere(
//             (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }
//
//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }
//
//   void signInWithGoogle() async {
//     try{
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       print(googleAuth.accessToken);
//       print(googleAuth.idToken);
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       final User? user = userCredential.user;
//       // assert(user.email != null);
//       // assert(user.displayName != null);
//       // assert(!user.isAnonymous);
//       // assert(await user.getIdToken() != null);
//       String idTokenResult = await user!.getIdToken(true);
//       setState(() {
//         idToken = idTokenResult;
//       });
//     }catch(e){
//       // SnackTool.showSnackText(context, "Auth error !");
//     }
//   }
//
//
//   Future<void> _handleSignOut() => _googleSignIn.disconnect();
//
//   Widget _buildBody() {
//     GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text("Signed in successfully."),
//           Text(_contactText),
//           ElevatedButton(
//             child: const Text('SIGN OUT'),
//             onPressed: _handleSignOut,
//           ),
//           ElevatedButton(
//             child: const Text('REFRESH'),
//             onPressed: () => _handleGetContact(user),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text("You are not currently signed in."),
//           ElevatedButton(
//             child: const Text('SIGN IN'),
//             onPressed: signInWithGoogle,
//           ),
//         ],
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }