import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/common/components/primary_text_field.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';

class PostTweetPage extends StatelessWidget {
  const PostTweetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tweetViewModel = context.read<TweetViewModel>();
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        leading: LeadingCancelButton(context),
        leadingWidth: 100,
        actions: [
          ElevatedButton(
            onPressed: () async {
              await tweetViewModel.postTweet().then((value) => context.pop());
              tweetViewModel.endProcess();
            },
            child: Text("ツイートする"),
          ),
        ],
      ),
      body: Consumer<TweetViewModel>(
        builder: (context, model, child) {
          return model.isProcessing
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                          "https://placehold.jp/150x150.png"),
                    ),
                    Expanded(
                      child: PrimaryTextField(
                        hintText: "いまどうしてる？",
                        controller: model.descController,
                        isMultiLine: true,
                        height: 200,
                        maxLines: 9,
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
