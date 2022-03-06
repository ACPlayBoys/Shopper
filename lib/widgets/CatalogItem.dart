import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/screens/cart.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:velocity_x/velocity_x.dart";
import 'ItemWid.dart';

class CatalogItem extends StatelessWidget {
  final Item Catalog;
  final keyy;
  const CatalogItem(this.Catalog,this.keyy, {Key? key})
      : assert(Catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(tag: this.keyy, child: ImageWid(imageSrc: Catalog.image)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            2.heightBox,
            Catalog.name.text
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .bold
                .lg
                .make()
                .scrollHorizontal()
                .expand(),
            Catalog.desc.text
                .overflow(TextOverflow.clip)
                .make()
                .scrollVertical()
                .expand(),
            RatingBarIndicator(
              direction: Axis.horizontal,
              itemSize: 16.0,
              rating: Catalog.rate,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: Vx.mH8,
              children: [
                "\$${Catalog.price}".text.bold.make(),
                ElevatedButton(
                  onPressed: () {
                    Catalog.cartCount == 0
                        ? {
                            CatalogModel.cartItems.add((Catalog)),
                            Catalog.cartCount++
                          }
                        : Catalog.cartCount++;
                  },
                  child: "Buy".text.color(Colors.white).make(),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MTheme.darkBluish),
                      shape: MaterialStateProperty.all(StadiumBorder())),
                )
              ],
            ).pOnly(right: 8.0)
          ],
        ).expand()
      ],
    )).white.roundedLg.square(150).make();
  }
}
