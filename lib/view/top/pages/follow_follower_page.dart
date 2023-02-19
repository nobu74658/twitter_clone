import 'package:flutter/material.dart';
import 'package:twitter_clone/view/common/components/leading_cancel_button.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';

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
        children: [],
      ),
    );
  }
}
