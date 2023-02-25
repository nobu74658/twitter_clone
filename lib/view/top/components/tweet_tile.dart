import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/utils/formatter.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/top/components/user_circle_icon.dart';
import 'package:twitter_clone/view_model/favorite_view_model.dart';
import 'package:twitter_clone/view_model/page_view_model.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';

class TweetTile extends StatelessWidget {
  const TweetTile({
    super.key,
    required this.tweet,
    this.currentUserId,
    required this.favoriteTweets,
  });

  final Tweet tweet;
  final String? currentUserId;
  final List<Tweet> favoriteTweets;

  @override
  Widget build(BuildContext context) {
    final isFavorite = favoriteTweets.contains(tweet);
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
          _leftSide(context, tweet.userIcon, tweet.userId),
          const SizedBox(width: 10),
          _rightSide(
            tweet.userName,
            context,
            isFavorite,
          ),
        ],
      ),
    );
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

  _rightSide(String? userName, BuildContext context, bool isFavorite) {
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
          _likePart(context, isFavorite),
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
                icon: const Icon(Icons.close),
                onPressed: () async {
                  final tweetViewModel = context.read<TweetViewModel>();
                  await tweetViewModel.deleteTweet(tweet).then(
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

  _likePart(BuildContext context, bool isFavorite) {
    final favoriteViewModel = context.read<FavoriteViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        currentUserId == tweet.userId
            ? Container()
            : isFavorite
                ? IconButton(
                    splashRadius: 20,
                    onPressed: () async {
                      await favoriteViewModel.deleteFavoriteTweet(tweet);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 16,
                    ),
                  )
                : IconButton(
                    splashRadius: 20,
                    onPressed: () async {
                      await favoriteViewModel.setFavoriteTweet(tweet);
                    },
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      size: 16,
                    ),
                  ),
        SizedBox(
          width: 20,
          child: Text(
            "${tweet.favoriteNum}",
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
