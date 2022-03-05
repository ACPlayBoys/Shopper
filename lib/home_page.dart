import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopper"),
      ),
      body: Center(
        child: Container(
          child: const Text("this app"),
        ),
      ),
      drawer: Drawer(),
    );
  }
}
