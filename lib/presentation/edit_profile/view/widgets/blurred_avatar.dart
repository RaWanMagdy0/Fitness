import 'dart:ui';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

class BlurredAvatar extends StatelessWidget {
  final String imageUrl;

  const BlurredAvatar({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Circular Image with blur effect
        ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: 100,  // Adjust size as needed
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),  // Replace with AssetImage if local
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Glowing effect using RadialGradient
        Container(
          width: 110,  // Slightly larger than the image for glow effect
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.orange.withOpacity(0.5), Colors.transparent],
              stops: [0.6, 1.0],
            ),
          ),
        ),
        // Edit Icon
        Positioned(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.edit, color: AppColors.kOrange),
          ),
        ),
      ],
    );
  }
}
