import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_application_1/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;
  bool anime = false;
  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value == 1) {
        anime = true;
        if (FirebaseAuth.instance.currentUser == null) {
          _coffeeController.removeListener(() {});
          _coffeeController.forward();
          copAnimated = true;
          setState(() {});
          Future.delayed(const Duration(seconds: 1), () async {
            animateCafeText = true;
            setState(() {});
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () async {
            await Navigator.of(context).push(myroutes.Home_createRoute());
          });
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Stack(
        
        children: [
          // White Container top half
          AnimatedContainer(            
            duration: const Duration(seconds: 1),
            height: copAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(copAnimated ? 40.0 : 0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: AnimatedCrossFade(
                    duration: Duration(seconds: 1),
                    firstChild: Lottie.asset(
                      "assests/images/71390-shopping-cart-loader.json",
                      height: 400,
                      repeat: true,
                      controller: anime == false ? _coffeeController : null,
                      onLoaded: (composition) {
                        _coffeeController.duration = composition.duration;
                        _coffeeController.forward();
                      },
                    ),
                    secondChild: Lottie.asset(
                      "assests/images/71390-shopping-cart-loader.json",
                      height: 200.0,
                    ),
                    crossFadeState: copAnimated
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: animateCafeText ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Text(
                      'Shopper',
                      style: GoogleFonts.pacifico(
                        fontSize: 50.0,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: copAnimated, child: _BottomPart()),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Login_Screen(),
    );
  }
}
