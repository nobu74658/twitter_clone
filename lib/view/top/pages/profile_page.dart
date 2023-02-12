import 'package:flutter/material.dart';
import 'package:twitter_clone/view/common/components/sign_out_text_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("プロフィール編集"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "山田太郎",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("初めまして、山田太郎です。フォローしてください。" * 10),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("104フォロー中"),
              const SizedBox(width: 10),
              Text("392フォロワー"),
              const Spacer(),
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
