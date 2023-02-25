import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/top/components/tweet_tile.dart';
import 'package:twitter_clone/view_model/favorite_view_model.dart';

class FavoriteTweetPage extends StatelessWidget {
  const FavoriteTweetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteViewModel>(builder: (context, model, child) {
        return ListView.builder(
          itemCount: model.favoriteTweets.length,
          itemBuilder: (context, index) {
            return TweetTile(
                tweet: model.favoriteTweets[index],
                favoriteTweets: model.favoriteTweets);
          },
        );
      }),
    );
  }
}
