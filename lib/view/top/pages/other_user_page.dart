import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/tweet.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/top/common/tweet_tile.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class OtherUserPage extends StatelessWidget {
  const OtherUserPage({super.key, required this.userId});

  final String? userId;

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
          final user = snapshot.data;
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("tweets")
                .where("userId", isEqualTo: userId)
                .orderBy("postDateTime", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print("streamBuilder: fired in time_line_page");
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                                  backgroundImage: CachedNetworkImageProvider(
                                      user?.userIcon ??
                                          "https://placehold.jp/150x150.png"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                user?.userName ?? "unknown",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("フォローする"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(user?.bio ?? ""),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _followFolowedButton(
                            onPressed: () {},
                            isFollow: false,
                            num: user?.follow,
                          ),
                          const SizedBox(width: 10),
                          _followFolowedButton(
                            onPressed: () {},
                            num: user?.follower,
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Divider()
                    ][index];
                  } else {
                    final data = docs[index - 6].data() as Map<String, dynamic>;
                    final tweet = Tweet.fromMap(data);
                    return TweetTile(tweet: tweet);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<User> _future(BuildContext context) async {
    final userViewModel = context.read<UserViewModel>();
    return await userViewModel.getUserInfoById(userId ?? "");
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
        isFollow ? "$numフォロー中" : "$numフォロー",
      ),
    );
  }
}
