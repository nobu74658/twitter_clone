import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/sign_out_text_button.dart';
import 'package:twitter_clone/view/top/components/tweet_tile.dart';
import 'package:twitter_clone/view_model/favorite_view_model.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    final currentUser = userViewModel.currentUser;
    final favoriteViewModel = context.read<FavoriteViewModel>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const Align(
            alignment: Alignment.topRight,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                      currentUser?.userIcon ??
                          "https://placehold.jp/150x150.png"),
                ),
                const SignOutTextButton(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            currentUser?.userName ?? "unknown",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(currentUser?.bio ?? "プロフィール文章が未設定です"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context.go(kEditProfilePath);
            },
            child: const Text("プロフィール編集"),
          ),
          const SizedBox(height: 10),
          Consumer<UserViewModel>(
            builder: (context, model, child) {
              return Row(
                children: [
                  _followFolowedButton(
                    context: context,
                    num: model.currentUser?.followingNum,
                  ),
                  const SizedBox(width: 10),
                  _followFolowedButton(
                    context: context,
                    isFollow: false,
                    num: model.currentUser?.followedNum,
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go(kEmailResetAuthPath);
                },
                child: const Text("メールアドレスを変更"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  context.go(kPassResetAuthPath);
                },
                child: const Text("パスワードを変更"),
              ),
            ],
          ),
          Consumer<TweetViewModel>(builder: (context, model, child) {
            return SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: model.currentUserTweets.length,
                itemBuilder: (context, index) {
                  return TweetTile(
                    tweet: model.currentUserTweets[index],
                    currentUserId: currentUser!.userId,
                    favoriteTweets: favoriteViewModel.favoriteTweets,
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  _followFolowedButton({
    required BuildContext context,
    required int? num,
    bool isFollow = true,
  }) {
    return TextButton(
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
      ),
      onPressed: () => context.push(isFollow ? kFollowPath : kFollowerPath),
      child: Text(isFollow ? "$numフォロー中" : "$numフォロワー"),
    );
  }
}
