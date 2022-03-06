import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/widgets/Cart_Item.dart';
import 'package:flutter_application_1/widgets/ItemWid.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/src/flutter/sizedbox.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/utils/routes.dart';

// ignore: prefer_const_constructors
class CartPage extends StatelessWidget {
  final index;
  CartPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopper"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CatalogModel.cartItems != null &&
                  CatalogModel.cartItems.isNotEmpty
              ? GridView.builder(
                  itemBuilder: (context, i) {
                    if (i == CatalogModel.cartItems.length)
                      return CircularProgressIndicator.adaptive();
                    final Item item = CatalogModel.cartItems[i];

                    return CartItem(item,index);
                  },
                  itemCount: CatalogModel.cartItems.length,
                  // ignore: prefer_const_constructors
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                )
              : loadingItems()),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        buttonPadding: Vx.mH8,
        children: [
          "Total : ${CatalogModel.calculatePrice()}"
              .text
              .bold
              .xl2
              .red800
              .make(),
          ElevatedButton(
            onPressed: () {
              doUpiTransation();
            },
            child: "Buy".text.color(Colors.white).make(),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MTheme.darkBluish),
                shape: MaterialStateProperty.all(StadiumBorder())),
          ).wh(100, 50)
        ],
      ),
    );
  }

  Center? loadingItems() {
    return Center(
      child: Icon(
        Icons.remove_shopping_cart,
        size: 50,
      ),
    );
  }

  Future? doUpiTransation() async {
    return null;
  }
}
