// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/cart.dart';
import 'package:flutter_application_1/widgets/CatalogHeader.dart';
import 'package:flutter_application_1/widgets/ItemList.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/item_widget.dart';
import 'package:flutter_application_1/widgets/themes.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //User? user = FirebaseAuth.instance.currentUser;
    var profilePic =
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assests/images/7328930.png"),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12.5)),
                child: InkWell(
                  child:
                      Icon(Icons.edit_rounded, color: Colors.black, size: 15),
                ),
              ),
            )
          ],
        ),
      ),
    ]);
    return Scaffold(
      drawer: MDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            centerTitle: true,
            floating: true,
            title: "Profile".text.make(),
            leading: IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () {
                context.scaffold.openDrawer();
              },
            ),
          )
        ],
        body: SafeArea(
          bottom: false,
          child: Stack(children: [
            VxArc(
              edge: VxEdge.TOP,
              arcType: VxArcType.CONVEY,
              height: 50,
              child: Container(
                color: MTheme.creamColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profilePic,
                10.heightBox,
                "Aniket Chaudhary".text.xl.bold.make(),
                "AniketChaudharyjavaprog@gmail.com".text.make(),
                30.heightBox,
                InkWell(
                    onTap: () => print("tap"),
                    child: buildBtns(
                        Icons.person, "Your Details", 50, Colors.amberAccent)),
                15.heightBox,
                InkWell(
                    onTap: () => print("tap"),
                    child: buildBtns(Icons.shopping_bag, "Your Orders", 50,
                        Colors.amberAccent)),
                15.heightBox,
                InkWell(
                    onTap: () => print("tap"),
                    child: buildBtns(
                        Icons.settings, "Settings", 50, Colors.amberAccent)),
                15.heightBox,
                InkWell(
                    onTap: () => print("tap"),
                    child: buildBtns(
                        Icons.help, "Help & Support", 50, Colors.amberAccent)),
                15.heightBox,
                InkWell(
                    onTap: () => print("tap"),
                    child: buildBtns(Icons.person_remove_sharp, "Sign Out", 30,
                        Colors.white)),
                15.heightBox,
              ],
            ).scrollVertical(),
          ]),
        ),
      ),
    );
  }
}

class buildBtns extends StatelessWidget {
  final icon1;
  final String label;
  final double size;
  final color;

  const buildBtns(this.icon1, this.label, this.size, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: size == 50 ? null : 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon1),
          Spacer(),
          label.text.bold.xl.make(),
          Spacer(),
          Icon(size == 50 ? Icons.forward : Icons.exit_to_app_rounded),
        ],
      ).px12(),
    );
  }
}
