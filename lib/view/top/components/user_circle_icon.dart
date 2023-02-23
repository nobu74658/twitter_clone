import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserCircleIcon extends StatelessWidget {
  const UserCircleIcon({super.key, this.userIcon, this.radius, this.onPressed});

  final String? userIcon;
  final double? radius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(
          userIcon ?? "https://placehold.jp/150x150.png",
        ),
      ),
    );
    ;
  }
}
