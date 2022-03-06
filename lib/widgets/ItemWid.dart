import "package:velocity_x/velocity_x.dart";
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/src/flutter/container.dart';

class ImageWid extends StatelessWidget {
  final String imageSrc;
  const ImageWid({
    Key? key,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(imageSrc)
        .box
        .rounded
        .p8
        .color(MTheme.creamColor)
        .make()
        .p16()
        .w40(context);
  }
}
