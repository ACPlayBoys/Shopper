import 'package:firebase/firebase_io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SplashScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/themes.dart';

import 'utils/config.dart';

final configurations = config();
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // print(FirebaseAuth.instance.currentUser);

  await Firebase.initializeApp();
  print(FirebaseAuth.instance.currentUser?.displayName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: MTheme.darkTheme(context),
      routes: {
        "/": (context) => SplashScreen(),
        myroutes.home: (context) => HomePage(),
      },
    );
  }
}
