import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/utils/formatter.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class TweetTile extends StatelessWidget {
  const TweetTile({super.key, required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(context),
      builder: (context, snapshot) {
        final user = snapshot.data;
        print("tweet_tile: $user");
        return Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _leftSide(user?.userIcon),
              const SizedBox(width: 10),
              _rightSide(user?.userName),
            ],
          ),
        );
      },
    );
  }

  Future<User> _future(BuildContext context) async {
    final userViewModel = context.read<UserViewModel>();
    return await userViewModel.getUserInfoById(tweet.userId);
  }

  _leftSide(String? userIcon) {
    return CircleAvatar(
      radius: 18,
      backgroundImage: CachedNetworkImageProvider(
        userIcon ?? "https://placehold.jp/150x150.png",
      ),
    );
  }

  _rightSide(String? userName) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _postInfoPart(userName),
          const SizedBox(height: 2),
          Text(
            tweet.desc,
            maxLines: 10,
            softWrap: true,
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 6),
          _likePart(),
        ],
      ),
    );
  }

  _postInfoPart(String? userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          userName ?? "unknown",
        ),
        Text(dateFormatter.format(tweet.postDateTime)),
      ],
    );
  }

  _likePart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.favorite_border_outlined,
          size: 16,
        ),
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 16,
        ),
        Text(
          "${tweet.favorite}",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
