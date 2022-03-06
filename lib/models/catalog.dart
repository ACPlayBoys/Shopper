import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Item {
  final int id;
  final String name;
  final String desc;
  final double price;
  final String category;
  final String image;
  int cartCount = 0;

  String count;

  double rate;

  var trendKey;

  var catKey;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.category,
      required this.cartCount,
      required this.image,
      required this.rate,
      required this.catKey,
      required this.trendKey,
      required this.count});
  factory Item.fromJson(var json, int id) {
    return Item(
        name: json[id]['title'],
        desc: json[id]['description'],
        price: json[id]['price'].toDouble(),
        category: json[id]['category'],
        image: json[id]['image'],
        cartCount: 0,
        id: json[id]['id'],
        rate: json[id]["rating"]["rate"].toDouble(),
        count: json[id]["rating"]["count"].toString(),
        trendKey: GlobalKey(),
        catKey: GlobalKey());
  }
}

class CatalogModel {
  static late List<Item> items = [];
  static late List<Item> itemsOri = [];
  static late List<int> ids = [];
  static int tabindex = 0;
  static Map<String, TabModel> list = {};
  static late var cartItems = [];
  static bool fetching = false;
  static int id = 0;
  static Future<bool> fetch(
      {int init = 0,
      int limit = 10,
      String? category,
      required int ide}) async {
    String uri = "";
    if (category != null) {
      uri =
          "https://fakestoreapi.com/products/category/$category?limit=${limit.toString()}";
    } else {
      uri = "https://fakestoreapi.com/products?limit=${limit.toString()}";
    }
    String? data = await fetchProducts(uri);
    id = ide;
    print(json.decode(data!).length);
    print("Uri");
    print(id);
    if (data != null) {
      for (int i = 0, x = itemsOri.length; i < json.decode(data).length; i++,) {
        try {
          Item? item = parseProducts(data, i);
          if (item != null) {
            if (ids.contains(item.id) != true) {
              ids.add(item.id);
              itemsOri.add(item);
              items.add(item);
              list[item.category]?.add(x);
              x++;
              init++;
              id++;
            } else {
              id++;
            }
          }
        } on Exception catch (e) {
          print(e.toString());
          // TODO
        }
      }
    }
    printcheck();
    return fetching;
  }

  static void printcheck() {
    int? len1 = list["men's clothing"]?.ide.length;
    int? len2 = list["jewelery"]?.ide.length;
    int? len3 = list["women's clothing"]?.ide.length;
    int? len4 = list["electronics"]?.ide.length;
    print("for checkinh---------------");
    for (int i = 0; i < itemsOri.length; i++)
      print("${itemsOri[i].name}----${itemsOri[i].category}----$i");
    print("mens--clothing");
    for (int i = 0; i < len1!; i++) print(list["men's clothing"]?.ide[i]);

    print("jew--clothing");
    for (int i = 0; i < len2!; i++) print(list["jewelery"]?.ide[i]);
    print("womens--clothing");
    for (int i = 0; i < len3!; i++) print(list["women's clothing"]?.ide[i]);
    print("electronics--clothing");
    for (int i = 0; i < len4!; i++) print(list["electronics"]?.ide[i]);
    print("for checkinh---------------");
  }

  static void sort(int x, String parse) {
    print(parse);
    String cat = "";
    switch (x) {
      case 0:
        sortList(parse);
        break;
      case 1:
        cat = "electronics";
        sortMainList(cat, parse);
        break;
      case 2:
        cat = "women's clothing";
        sortMainList(cat, parse);
        break;
      case 3:
        cat = "men's clothing";
        sortMainList(cat, parse);
        break;
      case 4:
        cat = "jewelery";
        sortMainList(cat, parse);
        break;
    }
  }

  static void sortList(String parse) {
    switch (parse) {
      case 'Name(Ascending)':
        items.sort((a, b) {
          return a.name
              .toString()
              .toLowerCase()
              .compareTo(b.name.toString().toLowerCase());
        });
        break;
      case "Name(Descending)":
        items.sort((a, b) {
          return b.name
              .toString()
              .toLowerCase()
              .compareTo(a.name.toString().toLowerCase());
        });
        break;
      case "Populairty":
        items.sort((a, b) {
          return a.count
              .toString()
              .toLowerCase()
              .compareTo(b.count.toString().toLowerCase());
        });
        break;
      case "Rating":
        items.sort((a, b) {
          return b.rate.compareTo(a.rate);
        });
        break;
      case "Price(L to H)":
        items.sort((a, b) {
          return a.price.compareTo(b.price);
        });
        break;
      case "Price(H to L)":
        items.sort((a, b) {
          return b.price.compareTo(a.price);
        });
        break;
    }
  }

  static void sortMainList(String cat, String parse) {
    switch (parse) {
      case "Name(Descending)":
        list[cat]!.ide.sort((a, b) {
          return itemsOri[b]
              .name
              .toString()
              .toLowerCase()
              .compareTo(itemsOri[a].name.toString().toLowerCase());
        });
        break;
      case "Name(Ascending)":
        list[cat]!.ide.sort((a, b) {
          return itemsOri[a]
              .name
              .toString()
              .toLowerCase()
              .compareTo(itemsOri[b].name.toString().toLowerCase());
        });
        break;
      case "Populairty":
        list[cat]!.ide.sort((a, b) {
          return itemsOri[b].count.compareTo(itemsOri[a].count);
        });
        break;
      case "Rating":
        list[cat]!.ide.sort((a, b) {
          return itemsOri[b].rate.compareTo(itemsOri[a].rate);
        });
        break;
      case "Price(L to H)":
        list[cat]!.ide.sort((a, b) {
          return itemsOri[a].price.compareTo(itemsOri[b].price);
        });
        break;
      case "Price(H to L)":
        list[cat]!.ide.sort((a, b) {
          return itemsOri[b].price.compareTo(itemsOri[a].price);
        });
        break;
    }
  }

  static String calculatePrice() {
    double price = 0;
    for (int i = 0; i < cartItems.length; i++) {
      Item x = cartItems[i];
      price += x.price * x.cartCount;
    }

    print(price.toStringAsFixed(3));
    return "\$${price.toStringAsFixed(2)}";
  }

  static Item parseProducts(String responseBody, int id) {
    var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return (Item.fromJson(parsed, id));
  }

  static Future<String?> fetchProducts(String uri) async {
    var client = http.Client();
    print(uri);
    try {
      bool _validURL = Uri.parse(uri).isAbsolute;
      if (_validURL) {
        final response = await client.get(Uri.parse(uri));
        if (response.statusCode == 200) {
          fetching = true;
          return response.body;
        } else {
          fetching = false;
          throw Exception('Unable to fetch products from the REST API');
        }
      } else {
        fetching = false;
        return null;
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    } finally {
      client.close();
    }
  }

  static void initTab() {
    list["electronics"] = (new TabModel("electronics"));
    list["jewelery"] = (new TabModel("jewelery"));
    list["women's clothing"] = (new TabModel("women's clothing"));
    list["men's clothing"] = (new TabModel("men's clothing"));
  }

  static int lengthO(int index) {
    print(index);
    if (index == 0) {
      return CatalogModel.items.length;
    } else if (index == 1) {
      return CatalogModel.list["electronics"]!.ide.length;
    } else if (index == 2) {
      return CatalogModel.list["women's clothing"]!.ide.length;
    } else if (index == 3) {
      return CatalogModel.list["men's clothing"]!.ide.length;
    } else if (index == 4) {
      return CatalogModel.list["jewelery"]!.ide.length;
    } else {
      return 0;
    }
  }
}

class TabModel {
  List<int> ide = [];
  String category;
  TabModel(this.category);
  void add(int id) {
    ide.add(id);
  }
}
