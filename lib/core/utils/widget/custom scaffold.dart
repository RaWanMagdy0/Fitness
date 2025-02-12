import 'package:flutter/material.dart';

import 'dart:ui';


class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String backgroundImage;
  final double overlayOpacity;
  final bool enableBlur;
  final double blurStrength;
  final double blurHeight;
  final double blurWidth;
  final double borderRadius;
  final double blurStartPosition;

  const CustomScaffold({
    super.key,
    required this.child,
    required this.backgroundImage,
    this.overlayOpacity = 0.6,
    this.enableBlur = false,
    this.blurStrength = 10.0,
    this.blurHeight = 400.0,
    this.blurWidth = double.infinity,
    this.borderRadius = 20.0,
    this.blurStartPosition = 300.0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(overlayOpacity)),
          ),
          if (enableBlur)
            Positioned(
              top: blurStartPosition,
              left: (MediaQuery.of(context).size.width - blurWidth) / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
                  child: Container(
                    width: blurWidth,
                    height: blurHeight,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: SafeArea(child: child),
          ),
        ],
      ),
    );
  }
}
