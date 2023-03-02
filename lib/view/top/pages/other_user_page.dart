import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user/user.dart';
import 'package:twitter_clone/utils/keys.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/top/components/tweet_tile.dart';
import 'package:twitter_clone/view_model/favorite_view_model.dart';
import 'package:twitter_clone/view_model/follow_unfollow_view_model.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class OtherUserPage extends StatelessWidget {
  const OtherUserPage({super.key, required this.otherUserId});

  final String otherUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        leading: LeadingCancelButton(context),
        leadingWidth: 100,
      ),
      body: FutureBuilder(
        future: _future(context),
        builder: (context, snapshot) {
          final favoriteViewModel = context.read<FavoriteViewModel>();
          if (snapshot.connectionState == ConnectionState.done) {
            final otherUser = snapshot.data;
            if (otherUser != null) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(tweets_collection)
                    .where(user_id, isEqualTo: otherUserId)
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: const [
                          Icon(Icons.flutter_dash),
                          Text("不明なエラーが発生しました"),
                        ],
                      ),
                    );
                  }
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    itemCount: docs.length + 6,
                    itemBuilder: (context, index) {
                      if (index < 6) {
                        return [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(otherUser
                                                  .userIcon ??
                                              "https://placehold.jp/150x150.png"),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    otherUser.userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Consumer<FollowUnFollowViewModel>(
                                builder: (context, model, child) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      final userViewModel =
                                          context.read<UserViewModel>();
                                      await userViewModel
                                          .followUnFollowUser(otherUser,
                                              model.isFollowed == true)
                                          .then(
                                            (value) => model.changeIsFollow(
                                                !model.isFollowed),
                                          );
                                    },
                                    child: Text(model.isFollowed == true
                                        ? "フォロー解除"
                                        : "フォローする"),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(otherUser.bio),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _followFolowedButton(
                                onPressed: null,
                                num: otherUser.followingNum,
                              ),
                              const SizedBox(width: 10),
                              _followFolowedButton(
                                onPressed: null,
                                num: otherUser.followedNum,
                                isFollow: false,
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Divider()
                        ][index];
                      } else {
                        final data =
                            docs[index - 6].data() as Map<String, dynamic>;
                        final tweet = Tweet.fromMap(data);
                        return TweetTile(
                          tweet: tweet,
                          favoriteTweets: favoriteViewModel.favoriteTweets,
                        );
                      }
                    },
                  );
                },
              );
            } else {
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("＂ユーザーが見つかりませんでした"),
                ],
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<User> _future(BuildContext context) async {
    final userViewModel = context.read<UserViewModel>();
    final followUnFollowViewModel = context.read<FollowUnFollowViewModel>();
    final isFollowing = await userViewModel.isFollowingUser(otherUserId);
    final otherUser = await userViewModel.getUserInfoById(otherUserId);
    followUnFollowViewModel.changeIsFollow(isFollowing);
    return otherUser;
  }

  _followFolowedButton({
    required int? num,
    required VoidCallback? onPressed,
    bool isFollow = true,
  }) {
    return TextButton(
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
      ),
      onPressed: onPressed,
      child: Text(
        isFollow ? "$numフォロー中" : "$numフォロワー",
      ),
    );
  }
}
