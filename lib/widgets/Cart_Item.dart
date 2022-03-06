import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/screens/Product_screen.dart';
import 'package:flutter_application_1/widgets/Cart_Item.dart';
import 'package:flutter_application_1/widgets/ItemWid.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:velocity_x/src/flutter/sizedbox.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/utils/routes.dart';

class CartItem extends StatefulWidget {
  final Item item;
  final tabIndex;
  CartItem(this.item, this.tabIndex, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
 
  @override
  Widget build(BuildContext context) {
    GlobalKey keyy= widget.tabIndex==0?widget.item.trendKey:widget.item.catKey;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(myroutes.createRoute(widget.item, keyy))
            .then((value) {
          if (value == "refresh") {
            setState(() {});
            print("refresh");
          }
        });
      },
      child: Hero(
        tag: keyy,
        child: Card(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Stack(children: [
            Container(
              child: Image.network(widget.item.image).centered().py32(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                            width: 100,
                            child: "  ${widget.item.name}"
                                .text
                                .bold
                                .maxLines(1)
                                .align(TextAlign.left)
                                .overflow(TextOverflow.fade)
                                .make()
                                .scrollHorizontal())
                        .expand(),
                    InkWell(
                      onTap: () {
                        widget.item.cartCount = 0;
                        CatalogModel.cartItems.remove(widget.item);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.remove_circle_rounded,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ).px4().py2(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    "\$${widget.item.price} x ${widget.item.cartCount}"
                        .text
                        .bold
                        .align(TextAlign.left)
                        .overflow(TextOverflow.fade)
                        .make()
                        .px4(),
                    InkWell(
                      onTap: () {
                        if (widget.item.cartCount > 1) {
                          widget.item.cartCount--;
                        }
                        setState(() {});
                      },
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
