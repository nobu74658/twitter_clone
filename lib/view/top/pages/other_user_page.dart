import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/sign_out_text_button.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class OtherUserPage extends StatelessWidget {
  const OtherUserPage({super.key, required this.userId});

  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future(context),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return ListView(
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
                          user?.userIcon ?? "https://placehold.jp/150x150.png"),
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
                user?.userName ?? "unknown",
                style: TextStyle(fontWeight: FontWeight.bold),
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
            ],
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
