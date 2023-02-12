import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/top/pages/time_line_page.dart';
import 'package:twitter_clone/view/top/pages/like_page.dart';
import 'package:twitter_clone/view/top/pages/profile_page.dart';
import 'package:twitter_clone/view_model/page_view_model.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      TimeLinePage(),
      LikePage(),
      ProfilePage(),
    ];

    return Consumer<PageViewModel>(builder: (context, model, child) {
      return Scaffold(
        body: pages[model.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: model.currentIndex,
          unselectedItemColor: Colors.black54,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "ホーム",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "いいね",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "マイページ",
            ),
          ],
          onTap: (index) => model.pageTransition(index),
        ),
      );
    });
  }
}
