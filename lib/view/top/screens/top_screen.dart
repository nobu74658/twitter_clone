import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view/top/pages/home_page.dart';
import 'package:twitter_clone/view/top/pages/message_page.dart';
import 'package:twitter_clone/view/top/pages/notify_page.dart';
import 'package:twitter_clone/view/top/pages/search_page.dart';
import 'package:twitter_clone/view_model/page_view_model.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      HomePage(),
      SearchPage(),
      NotifyPage(),
      MessagePage(),
    ];

    return Consumer<PageViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: PrimaryAppBar(
          appBar: AppBar(),
        ),
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
              icon: Icon(Icons.search),
              label: "検索",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "通知",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: "メッセージ",
            ),
          ],
          onTap: (index) => model.pageTransition(index),
        ),
      );
    });
  }
}
