import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:implicitly_animated_list/implicitly_animated_list.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

import 'package:flutter_application_1/utils/routes.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Item> result = [];

  @override
  Widget build(BuildContext context) {
    User? user = null; //FirebaseAuth.instance.currentUser;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      elevation: 1,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(60),
      onQueryChanged: (query) {
        result.clear();
        if (query.isEmpty) {
          setState(() {});
          return;
        } else if (query.length > 3) {
          CatalogModel.itemsOri.forEach((userDetail) {
            if (userDetail.name.toLowerCase().contains(query.toLowerCase()) ||
                userDetail.desc.toLowerCase().contains(query.toLowerCase()))
              result.add(userDetail);
          });
          setState(() {});
        }
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
              ),
            );
          },
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        IconButton(
          icon: User == null
              ? Icon(Icons.person_rounded)
              : Icon(Icons.person_rounded), //ImageIcon(NetworkImage(user.photoURL.toString())),
          onPressed: () {},
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(children: [
                ImplicitlyAnimatedList(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  shrinkWrap: true,
                  itemData: result,
                  itemBuilder: (context, index1) {
                    Item catalog = index1 as Item;
                    GlobalKey unq = GlobalKey();
                    return InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => {
                              Navigator.of(context)
                                  .push(myroutes.createRoute(catalog, unq))
                            },
                        child: ListTile(
                          title: catalog.name.text.make(),
                          leading: Hero(
                            tag: unq,
                            child: Image.network(catalog.image),
                          ),
                        ));
                  },
                ),
              ])),
        );
      },
    );
  }
}
