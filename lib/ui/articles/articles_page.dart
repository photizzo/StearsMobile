import 'package:bawo/data/core/view_state.dart';
import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:bawo/ui/routes/routes.dart';
import 'package:bawo/utils/app_fonts.dart';
import 'package:bawo/utils/color.dart';
import 'package:bawo/widgets/app_divider.dart';
import 'package:bawo/widgets/app_progress_bar.dart';
import 'package:bawo/widgets/circle_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home_page.dart' as sharedProvider;

class ArticlesPage extends HookWidget {
  List<Article> articles;

  ArticlesPage(this.articles);

  @override
  Widget build(BuildContext context) {
    bool isLoading =
        useProvider(sharedProvider.homeProvider).viewState == ViewState.Loading;
    return isLoading
        ? Center(
            child: AppProgressBar(),
          )
        : Container(
            child: articles.isEmpty
                ? Center(
                    child: AppFontsStyle.getAppTextView(
                        "No stories to read at the moment 🥳",
                        size: 18),
                  )
                : ListView.separated(
                    itemCount: articles.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        AppDivider(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.articleDetails,
                                arguments: articles[index]);
                          },
                          child: ArticleItem(articles[index]));
                    },
                  ),
          );
  }
}

class ArticleItem extends HookWidget {
  Article article;

  ArticleItem(this.article);

  @override
  Widget build(BuildContext context) {
    final favoriteIds = useProvider(sharedProvider.homeProvider).favoriteIds;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleImageFromNetwork(
                article.author.avatar,
                "placeholder",
                "errorHolder",
                size: 18,
              ),
              SizedBox(
                width: 6,
              ),
              AppFontsStyle.getAppTextView(article.author.name, size: 12)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppFontsStyle.getAppTextViewBold(article.title),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      AppFontsStyle.getAppTextView(article.date),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.circle,
                        size: 4,
                        color: Pallet.colorBawoGrey,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      AppFontsStyle.getAppTextView(article.minRead),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  width: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3)),
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Image.asset(
                        "assets/images/dummy_image.png",
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/dummy_image.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AppFontsStyle.getAppTextView("Based on your reading history",
                size: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read(sharedProvider.homeProvider)
                        .updateFavorite(article);
                  },
                  child: Icon(
                    favoriteIds.contains(article.id)
                        ? Icons.bookmarks
                        : Icons.bookmarks_outlined,
                    color: Pallet.colorBawoGrey,
                    size: 14,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SvgPicture.asset(
                  "assets/images/options_menu.svg",
                  height: 12,
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
