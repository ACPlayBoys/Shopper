import 'package:flutter_application_1/widgets/SearchWidget.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/screens/cart.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/CatalogHeader.dart';
import 'package:flutter_application_1/widgets/CatalogItem.dart';
import 'package:flutter_application_1/widgets/ItemList.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/item_widget.dart';
import 'package:flutter_application_1/widgets/themes.dart';

// ignore: prefer_const_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabbar;
  static final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a

  var _currentMax = 0;

  @override
  void initState() {
    // TODO: implementinitState

    super.initState();

    CatalogModel.initTab();
    _getMoreData(0);
    tabbar = TabController(length: 5, vsync: this);
    tabbar.addListener(() {
      CatalogModel.tabindex = tabbar.index;
      print(CatalogModel.tabindex);
    });
    _currentMax = CatalogModel.items.length;
  }

  _getMoreData(int i) {
    fetcher();
    if (CatalogModel.lengthO(i) == 0) setState(() {});
  }

  Future<void> fetcher() async {
    bool ch = CatalogModel.fetching;
    if (CatalogModel.id < 20) {
      // ch = await CatalogModel.fetch();
      //setState(() {});
    }
  }

  FloatingSearchBarController CCCC = FloatingSearchBarController();
  Widget buildFloatingSearchBar() {
    return SearchWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: MDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(myroutes.Profile_createRoute(
                //CatalogModel.tabindex
                ));
          },
          child: Icon(Icons.shopping_cart_rounded),
        ),
        body: Stack(children: [
          SafeArea(
            child: Container(
              padding: Vx.m16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      40.heightBox,
                    ],
                  ),
                  "Shopper"
                      .text
                      // ignore: deprecated_member_use
                      .textStyle(Theme.of(context).accentTextTheme.bodyText1!)
                      .xl5
                      .color(Theme.of(context).primaryColor)
                      .make(),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                          controller: tabbar,
                          labelPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          indicator: CircleTabIndicator(
                              color: Colors.black, radius: 2),
                          tabs: [
                            "trending".text.xl.make(),
                            "electronics".text.xl.make(),
                            "women's clothing".text.xl.make(),
                            "men's clothing".text.xl.make(),
                            "jewelery".text.xl.make(),
                          ]),
                    ),
                  ),
                  Container(
                    child: TabBarView(controller: tabbar, children: [
                      ItemList(0),
                      ItemList(1),
                      ItemList(2),
                      ItemList(3),
                      ItemList(4),
                    ]).expand(),
                  )
                ],
              ),
            ),
          ),
          buildFloatingSearchBar(),
        ]));
  }

  Center loadingItems() {
    //_getMoreData();
    return Center(child: CircularProgressIndicator.adaptive());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
