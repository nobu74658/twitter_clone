import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/utils/formatter.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/top/components/user_circle_icon.dart';
import 'package:twitter_clone/view_model/page_view_model.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class TweetTile extends StatelessWidget {
  const TweetTile({super.key, required this.tweet, this.currentUserId});

  final Tweet tweet;
  final String? currentUserId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(context),
      builder: (context, snapshot) {
        final user = snapshot.data;
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
              _leftSide(context, user?.userIcon, user?.userId),
              const SizedBox(width: 10),
              _rightSide(user?.userName, context),
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

  _leftSide(BuildContext context, String? userIcon, String? userId) {
    return UserCircleIcon(
      userIcon: userIcon,
      radius: 18,
      onPressed: () {
        final pageViewModel = context.read<PageViewModel>();
        currentUserId == userId
            ? pageViewModel.pageTransition(2)
            : context.push("$kOtherUserPath/$userId");
      },
    );
  }

  _rightSide(String? userName, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _postInfoPart(userName, context),
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

  _postInfoPart(String? userName, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              userName ?? "unknown",
            ),
            const SizedBox(width: 20),
            Text(dateFormatter.format(tweet.createdAt)),
          ],
        ),
        currentUserId == tweet.userId
            ? IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () async {
                  final tweetViewModel = context.read<TweetViewModel>();
                  await tweetViewModel.deleteTweet(tweet.tweetId).then(
                        (value) => showBottomSheet(
                          context: context,
                          builder: (context) {
                            return const Text("ツイートが削除されました。");
                          },
                        ),
                      );
                },
              )
            : Container(),
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
          "${tweet.favoriteNum}",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
