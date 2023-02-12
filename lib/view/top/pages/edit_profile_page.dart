import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view_model/user_view_model.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    final currentUser = userViewModel.currentUser;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  currentUser?.userIcon ?? "assets/images/unknown.png"),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              currentUser?.userName ?? "unknown",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Align(
              alignment: Alignment.center,
              child: Text(currentUser?.bio ?? "プロフィール文章が未設定です")),
        ],
      ),
    );
  }
}
