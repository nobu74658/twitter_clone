import 'package:flutter/material.dart';
import 'package:twitter_clone/data_models/user.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/top/common/icon_name_tile.dart';

class FollowFollowerPage extends StatelessWidget {
  const FollowFollowerPage({super.key, this.isFollow = true});

  final bool isFollow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        appBar: AppBar(),
        leading: LeadingCancelButton(context),
        leadingWidth: 100,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: [
          Align(
            alignment: Alignment.center,
            child: IconNameTile(
              user: User(
                createdAt: DateTime.now(),
                follow: 20,
                follower: 2,
                userId: 'jgowe',
                userName: 'テスト太郎',
              ),
            ),
          )
        ],
      ),
    );
  }
}
