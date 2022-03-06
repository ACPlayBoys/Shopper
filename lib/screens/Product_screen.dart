import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:velocity_x/velocity_x.dart";

class ProductPage extends StatelessWidget {
  final catalog;
  final keyy;

  const ProductPage({Key? key, this.catalog, @required this.keyy})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MTheme.creamColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart_rounded),
            onPressed: () {
              Navigator.of(context).push(myroutes.Cart_createRoute(CatalogModel.tabindex));
            },
          ),
        ],
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        buttonPadding: Vx.mH8,
        children: [
          "\$${catalog.price}".text.bold.xl4.red800.make(),
          ElevatedButton(
            onPressed: () {
              catalog.cartCount == 0
                  ? {CatalogModel.cartItems.add((catalog)), catalog.cartCount++}
                  : catalog.cartCount++;
            },
            child: "Buy".text.color(Colors.white).make(),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MTheme.darkBluish),
                shape: MaterialStateProperty.all(StadiumBorder())),
          ).wh(100, 50)
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(tag: keyy, child: Image.network(catalog.image)).h32(context),
            Expanded(
              child: VxArc(
                height: 30,
                edge: VxEdge.TOP,
                arcType: VxArcType.CONVEY,
                child: Container(
                  color: Colors.white,
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RatingBarIndicator(
                            direction: Axis.horizontal,
                            itemSize: 25.0,
                            rating: catalog.rate,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                          ),
                        ],
                      ).px16(),
                      "${catalog.name}".text.bold.xl2.make().px12(),
                      SizedBox(
                        height: 10,
                      ),
                      "${catalog.desc}"
                          .text
                          .xl
                          .color(Colors.black)
                          .make()
                          .px16(),
                      5.heightBox,
                    ],
                  ).py32().scrollVertical(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
