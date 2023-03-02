import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/utils/path.dart';
import 'package:twitter_clone/view/common/components/primary_app_bar.dart';
import 'package:twitter_clone/view_model/page_view_model.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.child,
    required this.context,
  });

  final Widget child;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageViewModel>(builder: (context, model, modelChild) {
      return Scaffold(
        appBar: PrimaryAppBar(
          appBar: AppBar(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go(kPostTweetPath);
          },
          child: const Icon(Icons.add),
        ),
        body: child,
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
          onTap: (index) {
            model.pageTransition(index);
            switch (index) {
              case 0:
                context.go(kTimeLinePath);
                break;
              case 1:
                context.go(kFavoriteTweetPath);
                break;
              case 2:
                context.go(kProfilePath);
                break;
            }
          },
        ),
      );
    });
  }
}
