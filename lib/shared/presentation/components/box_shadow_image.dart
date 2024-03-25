import 'package:flutter/material.dart';

/// Author: Liam Welsh
class BoxShadowImage extends StatefulWidget {
  static const boxShadowColor = Colors.black;
  static const boxShadowOpacity = 0.5;

  final double textPadding;
  final Image? image;
  final void Function()? onTap;
  final Text text;
  final double? height;
  final double? width;

  const BoxShadowImage(
      {super.key,
      this.image,
      this.onTap,
      required this.text,
      this.textPadding = 10,
      this.height,
      this.width});

  @override
  State<BoxShadowImage> createState() => _BoxShadowImageState();
}

class _BoxShadowImageState extends State<BoxShadowImage> {
  var _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        height: widget.image?.height ?? widget.height,
        width: widget.image?.width ?? widget.width,
        decoration: BoxDecoration(
          image: widget.image != null
              ? DecorationImage(
                  image: widget.image!.image,
                  fit: BoxFit.cover,
                )
              : null,
          color: widget.image == null
              ? Theme.of(context).appBarTheme.backgroundColor
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: _isPressed
                  ? BoxShadowImage.boxShadowColor
                  : BoxShadowImage.boxShadowColor
                      .withOpacity(BoxShadowImage.boxShadowOpacity),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.black.withOpacity(0.4),
            ),
            padding: EdgeInsets.all(widget.textPadding),
            child: FittedBox(
              fit: BoxFit.contain,
              child: widget.text,
            )),
      ),
    );
  }
}
