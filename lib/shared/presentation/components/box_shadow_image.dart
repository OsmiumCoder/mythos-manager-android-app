import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Author: Liam Welsh
class BoxShadowImage extends StatefulWidget {
  static const boxShadowColor = Colors.black;
  static const boxShadowOpacity = 0.5;

  final double textPadding;
  final Image image;
  final void Function()? onTap;
  final Text text;
  const BoxShadowImage(
      {super.key, required this.image, this.onTap, required this.text, this.textPadding = 10});

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
        height: widget.image.height,
        width: widget.image.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.image.image,
            fit: BoxFit.cover,
          ),
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
                fit: BoxFit.fitWidth,
                  child: widget.text,
                )
        ),
      ),
    );
  }
}
