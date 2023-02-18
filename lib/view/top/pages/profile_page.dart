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
        padding: const EdgeInsets.all(20),
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: SignOutTextButton(),
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
                ElevatedButton(
                  onPressed: () {
                    context.push(kEditProfilePath);
                  },
                  child: Text("プロフィール編集"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            currentUser?.userName ?? "unknown",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(currentUser?.bio ?? "プロフィール文章が未設定です"),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("${currentUser?.follow}フォロー中"),
              const SizedBox(width: 10),
              Text("${currentUser?.follower}フォロワー"),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("メールアドレスを変更"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text("パスワードを変更"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
