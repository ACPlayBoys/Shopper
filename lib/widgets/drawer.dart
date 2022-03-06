import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_application_1/utils/routes.dart';

class MDrawer extends StatelessWidget {
  late User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Expanded(
        child: ListView(
          children: <Widget>[
            // DrawerHeader(
            //   padding: EdgeInsets.zero,
            //   child: UserAccountsDrawerHeader(
            //     decoration: BoxDecoration(
            //       image: new DecorationImage(
            //         image: AssetImage("assests/images/bg image.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     margin: EdgeInsets.zero,
            //     accountEmail: Text(user!.email.toString()),
            //     accountName: Text(
            //       user!.displayName.toString(),
            //     ),
            //     currentAccountPicture: CircleAvatar(
            //       backgroundImage: NetworkImage(user!.photoURL.toString()),
            //     ),
            //   ),
            // ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(myroutes.Cart_createRoute(0));
              },
              leading: Icon(CupertinoIcons.shopping_cart),
              title: Text(
                "Cart",
                textScaleFactor: 1.2,
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.profile_circled),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.heart_circle_fill),
              title: Text(
                "Wishlist",
                textScaleFactor: 1.2,
              ),
            ),
          ],
        ),
      ),
      Container(
          // This align moves the children to the bottom
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                  child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                      leading: Icon(CupertinoIcons.settings),
                      title: Text('Settings')),
                  ListTile(
                      leading: Icon(CupertinoIcons.question_circle),
                      title: Text('Help and Feedback')),
                ],
              ))))
    ]));
  }
}
