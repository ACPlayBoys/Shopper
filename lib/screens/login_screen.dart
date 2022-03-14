// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:firebase/firebase_io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  String name = "";

  int chngBtn1 = 0, chngBtn2 = 0;

  Future<User?> _signin() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? gsa =
          await googleSignInAccount?.authentication;
      OAuthCredential user = GoogleAuthProvider.credential(
        accessToken: gsa?.accessToken,
        idToken: gsa?.idToken,
      );

      setState(() {
        chngBtn2 = 2;
      });
      await _auth.signInWithCredential(user);
      User? id = _auth.currentUser;
      return id;
    } on Exception catch (e) {
      // TODO
      chngBtn2 = 0;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var button1 = Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: () async {
          setState(() {
            chngBtn1 = 1;
          });
          await Future.delayed(Duration(seconds: 1));
          await Navigator.of(context).push(_createRoute());
          setState(() {
            chngBtn1 = 0;
          });
        },
        child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: chngBtn1 == 1 ? 50 : 150,
            height: 50,
            alignment: Alignment.center,
            child: buildButton1()),
      ),
    );
    var button2 = Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(chngBtn2 == 1 ? 50 : 50),
      child: InkWell(
        onTap: () async {
          setState(() {
            chngBtn2 = 1;
          });
          User? user = await _signin();
          if (user != null) {
            name = user.displayName!;
            setState(() {});
            await Future.delayed(Duration(seconds: 1));
            await Navigator.of(context).push(_createRoute());
          }
          setState(() {
            chngBtn2 = 0;
          });
        },
        child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: chngBtn2 == 1 ? 50 : 150,
            height: 50,
            alignment: Alignment.center,
            child: buildButton2()),
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Welcome to Shopper $name",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter UserName",
                      labelText: "Username",
                    ),
                    onChanged: (value) => {
                          if (value.length == 0)
                            {name = ""}
                          else
                            name = "," + value,
                          setState(() {})
                        }),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button1,
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("Or",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    button2
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void doe() {}

  Container buildButton1() {
    if (chngBtn1 == 1) {
      return Container(child: CircularProgressIndicator(color: Colors.white));
    } else if (chngBtn1 == 2) {
      return Container(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        child: Text(
          "Login",
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
  }

  Container buildButton2() {
    if (chngBtn2 == 1) {
      return Container(
          child: CircularProgressIndicator(
              color: Theme.of(context).backgroundColor));
    } else if (chngBtn2 == 2) {
      return Container(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      );
    } else
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: Image.asset(
              'assests/images/giphy.gif',
            ).image,
          ),
        ),
      );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
