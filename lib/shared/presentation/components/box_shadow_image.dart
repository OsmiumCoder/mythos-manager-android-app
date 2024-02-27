import 'package:flutter/material.dart';

class BoxShadowImage extends StatefulWidget {
  final Image image;
  final void Function()? onTap;
  final Text text;
  const BoxShadowImage({super.key, required this.image, this.onTap, required this.text});

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
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Colors.black
          ),
          boxShadow: [
            BoxShadow(
              color: _isPressed ? Colors.black : Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: widget.text
        ),
      ),
    );
  }
}

