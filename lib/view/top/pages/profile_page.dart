import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/sign_out_text_button.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    final currentUser = userViewModel.currentUser;

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
              context.push(kEditProfilePath);
            },
            child: const Text("プロフィール編集"),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _followFolowedButton(
                context: context,
                num: currentUser?.follow,
              ),
              const SizedBox(width: 10),
              _followFolowedButton(
                context: context,
                isFollow: false,
                num: currentUser?.follower,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push(kEmailResetAuthPath);
                },
                child: const Text("メールアドレスを変更"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  context.push(kPassResetAuthPath);
                },
                child: const Text("パスワードを変更"),
              ),
            ],
          ),
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
