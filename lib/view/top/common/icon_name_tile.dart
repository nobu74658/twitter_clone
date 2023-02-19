import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/user.dart';

class IconNameTile extends StatelessWidget {
  const IconNameTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          user.userIcon ?? "https://placehold.jp/150x150.png",
        ),
      ),
      title: Text(user.userName),
    );
  }
}