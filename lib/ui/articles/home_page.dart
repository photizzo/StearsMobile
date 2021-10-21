import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:bawo/domain/viewmodel/event_view_model.dart';
import 'package:bawo/utils/app_fonts.dart';
import 'package:bawo/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import 'articles_page.dart';

final homeProvider = ChangeNotifierProvider.autoDispose<EventViewModel>((ref) {
  ref.onDispose(() {});
  final viewmodel = locator.get<EventViewModel>();
  viewmodel.getRecentArticles();
  viewmodel.getFavoriteArticles();
  return viewmodel;
});

final _recentArticlesProvider = Provider.autoDispose<List<Article>>((ref) {
  return ref.watch(homeProvider).recentArticles;
});
final recentArticlesProvider = Provider.autoDispose<List<Article>>((ref) {
  return ref.watch(_recentArticlesProvider);
});

final _favoriteArticlesProvider = Provider.autoDispose<List<Article>>((ref) {
  return ref.watch(homeProvider).favoriteArticles;
});

final favoriteArticlesProvider = Provider.autoDispose<List<Article>>((ref) {
  return ref.watch(_favoriteArticlesProvider);
});

class HomePage extends StatefulHookWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tab = Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Pallet.colorWhite,
            border: Border(
                bottom: BorderSide(color: Pallet.colorBawoGrey, width: 0.8))),
        child: TabBar(
          indicatorColor: Pallet.colorPrimaryDark,
          indicatorWeight: 3,
          labelColor: Pallet.colorPrimaryDark,
          unselectedLabelColor: Pallet.colorBawoGrey,
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          labelStyle: TextStyle(
              fontFamily: AppFontsStyle.fontFamily,
              color: Pallet.colorPrimaryDark,
              fontSize: AppFontsStyle.titleNormalSize14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              height: 1.5),
          tabs: [
            Tab(
              text: "Recent",
              iconMargin: EdgeInsets.zero,
            ),
            Tab(
              text: "Favorites",
              iconMargin: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppFontsStyle.getAppTextViewBold("Home", size: 22),
                    Icon(
                      Icons.notifications_none_rounded,
                      size: 24,
                    )
                  ]),
            ),
            Expanded(
                child: DefaultTabController(
              length: 2,
              child: Column(children: [
                SizedBox(height: 10),
                tab,
                Expanded(
                  child: TabBarView(
                    children: [
                      ArticlesPage(useProvider(recentArticlesProvider)),
                      ArticlesPage(useProvider(favoriteArticlesProvider)),
                    ],
                  ),
                )
              ]),
            ))
          ],
        ),
      ),
    );
  }
}
