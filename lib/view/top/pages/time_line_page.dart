import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/tweet/tweet.dart';
import 'package:twitter_clone/view/top/components/tweet_tile.dart';
import 'package:twitter_clone/view_model/favorite_view_model.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    final currentUser = userViewModel.currentUser!;
    final favoriteViewModel = context.read<FavoriteViewModel>();
    final tweetViewModel = context.read<TweetViewModel>();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: tweetViewModel.getTweetSnapshot(),
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
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              60,
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final tweet = Tweet.fromJson(data);
              return TweetTile(
                tweet: tweet,
                currentUserId: currentUser.userId,
                favoriteTweets: favoriteViewModel.favoriteTweets,
              );
            },
          );
        },
      ),
    );
  }
}
