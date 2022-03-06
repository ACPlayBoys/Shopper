import 'package:flutter_application_1/screens/Product_screen.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';

import 'CatalogItem.dart';

class ItemList extends StatefulWidget {
  final int index;
  String value = "Sort By";
  ItemList(this.index, {Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>
    with AutomaticKeepAliveClientMixin<ItemList> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int currentPage = 5;
  int initPage = 0;

  num totalPages = 20;
  @override
  void initState() {
    //fetcher(isRefresh: true);
    super.initState();
  }

  Future<bool> fetcher({bool isRefresh = false}) async {
    if (isRefresh) {
      CatalogModel.id = 0;
    } else {
      // if (initPage >= totalPages) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }
    bool ch = false;
    String? cat = null;
    int id = 0;
    switch (widget.index) {
      case 0:
        cat = null;
        id = CatalogModel.lengthO(widget.index);
        break;
      case 1:
        cat = "electronics";
        id = CatalogModel.lengthO(widget.index);
        break;
      case 2:
        cat = "women's clothing";
        id = CatalogModel.lengthO(widget.index);
        break;
      case 3:
        cat = "men's clothing";
        id = CatalogModel.lengthO(widget.index);
        break;
      case 4:
        cat = "jewelery";
        id = CatalogModel.lengthO(widget.index);
        break;
    }
    id == 0 ? id = 0 : id -= 1;
    print("id++++ $id");
    ch = await CatalogModel.fetch(
        init: initPage, limit: currentPage, category: cat, ide: id);
    initPage = currentPage;
    currentPage += 5;
    setState(() {});

    return ch;
  }

  @override
  Widget build(BuildContext context) {
    print("refresh");
    return SmartRefresher(
      controller: refreshController,
      scrollController: ScrollController(),
      enablePullUp: true,
      onRefresh: () async {
        final result = await fetcher(isRefresh: true);
        if (result) {
          refreshController.refreshCompleted();
        } else {
          refreshController.refreshFailed();
        }
      },
      onLoading: () async {
        final result = await fetcher();
        if (result) {
          refreshController.loadComplete();
        } else {
          refreshController.loadFailed();
        }
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 5, bottom: 5),
            shrinkWrap: true,
            itemCount: CatalogModel.lengthO(widget.index),
            itemBuilder: (context, index1) {
              Item catalog = returnItem(this.widget.index, index1);
              GlobalKey unq =
                  this.widget.index == 0 ? catalog.trendKey : catalog.catKey;
              return InkWell(
                 // hoverColor: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => {
                        Navigator.of(context)
                            .push(myroutes.createRoute(catalog, unq))
                      },
                  child: CatalogItem(catalog, unq));
            },
            separatorBuilder: (BuildContext context, int index) {
              return 10.heightBox;
            },
          ),
          DropdownButton<String>(
            value: widget.value,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              if (newValue != "Sort By") {
                CatalogModel.sort(widget.index, newValue!);
                widget.value = newValue;
                setState(() {});
              }
            },
            items: <String>[
              "Sort By",
              'Name(Ascending)',
              "Name(Descending)",
              'Populairty',
              'Rating',
              'Price(L to H)',
              'Price(H to L)'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value.text
                    .color(value == "Sort By" ? Colors.grey : Colors.deepPurple)
                    .make(),
                enabled: value == "Sort By" ? false : true,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  returnItem(int index, int itemIndex) {
    if (index == 0)
      return CatalogModel.items[itemIndex];
    else if (index == 1) {
      print(CatalogModel.list["electronics"]!.ide[itemIndex]);
      Item ret = CatalogModel
          .itemsOri[CatalogModel.list["electronics"]!.ide[itemIndex]];
      return ret;
    } else if (index == 2)
      return CatalogModel
          .itemsOri[CatalogModel.list["women's clothing"]!.ide[itemIndex]];
    else if (index == 3)
      return CatalogModel
          .itemsOri[CatalogModel.list["men's clothing"]!.ide[itemIndex]];
    else if (index == 4)
      return CatalogModel
          .itemsOri[CatalogModel.list["jewelery"]!.ide[itemIndex]];
    else
      return 0;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
