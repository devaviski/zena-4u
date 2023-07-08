import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomFadeinImage extends StatelessWidget {
  const CustomFadeinImage({
    super.key,
    this.imageUrl,
    this.height,
  });

  final String? imageUrl;
  final double? height;

  @override
  Widget build(BuildContext context) {
    late ImageProvider<Object> targetImage;
    try {
      if (imageUrl == null) {
        targetImage = AssetImage('assets/images/placeholder.jpg');
      } else {
        targetImage = NetworkImage(imageUrl!);
      }
    } catch (e) {
      targetImage = AssetImage('assets/images/placeholder.jpg');
    }
    return FadeInImage(
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: MemoryImage(kTransparentImage),
      image: targetImage,
    );
  }
}
