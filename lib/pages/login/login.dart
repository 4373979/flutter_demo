import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  TextEditingController? _unameController;
  TextEditingController? _pwdController;
  String? idToken;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    setState(() {
      _contactText = _currentUser!.id;
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) =>
          new HomePage(user: _currentUser))
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg-cover.jpg'),
                fit: BoxFit.fill)
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            height: 530,
            margin: EdgeInsets.all(10),
            child: Form(
              child: Container(
                margin: EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Transform.scale(
                            scale: 3.0,
                            child: Image.asset('images/login.png')
                        )
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'User ID',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0))
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0))
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextButton(
                       style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                           padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                           minimumSize:MaterialStateProperty.resolveWith((states) => Size(double.infinity, 40)),
                       ),
                      // padding: const EdgeInsets.symmetric(vertical: 15),
                      // minWidth: double.infinity,
                      child: Text('Log in', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: (){},
                      // color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 10,),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
                        minimumSize:MaterialStateProperty.resolveWith((states) => Size(double.infinity, 40)),
                      ),
                      // padding: const EdgeInsets.symmetric(vertical: 15),
                      // minWidth: double.infinity,
                      child: Text('Sign up', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: (){},
                      // color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 30,),
                    Container(
                      alignment: Alignment.center,
                        child: Row(
                          mainAxisSize:MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset("images/google.jpg"),
                              iconSize: 30,
                              onPressed: (){
                                _handleSignIn();
                              },
                            ),
                            IconButton(
                              icon: Image.asset("images/apple.jpg"),
                              iconSize: 30,
                              onPressed: (){},
                            ),
                            IconButton(
                              icon: Image.asset("images/facebook.jpg"),
                              iconSize: 30,
                              onPressed: (){},
                            )
                          ],
                        )
                    ),
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
