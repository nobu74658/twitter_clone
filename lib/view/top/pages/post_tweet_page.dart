import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/common/components/primary_text_field.dart';
import 'package:twitter_clone/view_model/tweet_view_model.dart';

class PostTweetPage extends StatelessWidget {
  const PostTweetPage({super.key});

  @override
  Widget build(BuildContext context) {
    Image postImage = const Image(
        image: CachedNetworkImageProvider("https://placehold.jp/150x150.png"));
    final tweetViewModel = context.read<TweetViewModel>();
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        leading: LeadingCancelButton(context),
        leadingWidth: 100,
        actions: [
          ElevatedButton(
            onPressed: () async {
              await tweetViewModel
                  .postTweet()
                  .then((value) => context.go(kTimeLinePath));
              tweetViewModel.endProcess();
            },
            child: const Text("ツイートする"),
          ),
        ],
      ),
      body: Consumer<TweetViewModel>(
        builder: (context, model, child) {
          return model.isProcessing
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
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
                    ),
                    InkWell(
                      onTap: () async {
                        await model.getImage(isFromGallery: true);
                        if (model.isImagePicked) {
                          postImage = Image.file(model.imageFile!);
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: postImage.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
