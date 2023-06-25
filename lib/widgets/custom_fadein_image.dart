import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomFadeinImage extends StatelessWidget {
  const CustomFadeinImage({
    super.key,
    this.image,
    this.height,
  });

  final ImageProvider<Object>? image;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: MemoryImage(kTransparentImage),
      image: image ?? const AssetImage('assets/images/placeholder.jpg'),
    );
  }
}
