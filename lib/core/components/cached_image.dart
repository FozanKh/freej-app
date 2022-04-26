import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freej/core/components/animations/shimmer.dart';

import '../exports/core.dart';

class CachedImage extends StatelessWidget {
  final String? url;
  final Size? size;
  final Border? border;
  final BoxFit? fit;
  final BoxShape? shape;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? errorWidget;

  const CachedImage({
    Key? key,
    required this.url,
    this.size,
    this.border,
    this.fit,
    this.shape,
    this.margin,
    this.padding,
    this.boxShadow,
    this.borderRadius,
    this.errorWidget,
  })  : assert(borderRadius == null || shape != BoxShape.circle),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      imageBuilder: (context, imageProvider) => Container(
        height: size?.height,
        width: size?.width,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        margin: margin,
        padding: padding,
        foregroundDecoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: borderRadius,
          border: border,
        ),
        child: Image(
          image: imageProvider,
          fit: fit,
        ),
      ),
      placeholder: (context, url) => PlaceHolderContainer(
        margin: margin,
        boxDecoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          border: border,
        ),
        width: size?.width ?? 80,
        height: size?.height ?? 80,
      ),
      errorWidget: (context, url, error) => Container(
        margin: margin,
        padding: padding,
        alignment: Alignment.center,
        width: size?.width ?? 100,
        height: size?.height ?? 100,
        child: errorWidget ??
            Container(
              width: size?.width ?? 100,
              height: size?.height ?? 100,
              child: const Icon(Icons.error, color: kFontsColor, size: 30),
              decoration: BoxDecoration(
                shape: shape ?? BoxShape.rectangle,
              ),
            ),
      ),
    );
  }
}
