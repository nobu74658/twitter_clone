import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/top/components/icon_name_tile.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class FollowFollowerPage extends StatelessWidget {
  const FollowFollowerPage({super.key, this.isFollow = true});

  final bool isFollow;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final users = snapshot.data;
          print("users:${users?.length}");
          return Scaffold(
            appBar: PrimaryAppBar(
              appBar: AppBar(),
              leading: LeadingCancelButton(context),
              leadingWidth: 100,
            ),
            body: users != null
                ? users.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        children: [
                          for (int i = 0; i < users.length; i++)
                            Align(
                              alignment: Alignment.center,
                              child: IconNameTile(user: users[i]),
                            )
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                isFollow
                                    ? "フォロー中のユーザーがいません\n他のユーザーをフォローしてみましょう!!"
                                    : "フォロワーがいません\n右下の+ボタンからツイートしてみましょう!!",
                              ),
                            ),
                          ),
                        ],
                      )
                : Container(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<User>?> _future(BuildContext context) async {
    final userViewModel = context.read<UserViewModel>();
    final users = isFollow
        ? await userViewModel.getFollowUsers()
        : await userViewModel.getFollowers();
    return users;
  }
}
