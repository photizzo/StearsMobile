import 'package:bawo/utils/app_fonts.dart';
import 'package:bawo/utils/color.dart';
import 'package:bawo/widgets/circle_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home_page.dart' as sharedProvider;

class ArticleDetailsPage extends HookWidget {
  final article;

  ArticleDetailsPage(this.article);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final favoriteIds = useProvider(sharedProvider.homeProvider).favoriteIds;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: size.height / 3 - 20,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
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
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          children: [
                            CircleImageFromNetwork(
                              article.author.avatar,
                              "placeholder",
                              "errorHolder",
                              size: 24,
                              borderColor: Pallet.colorBlack,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            AppFontsStyle.getAppTextView(article.author.name,
                                size: 12),
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
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: AppFontsStyle.getAppTextViewBold(article.title,
                        size: 22)),
                SizedBox(
                  height: 16,
                ),
                Container(margin: EdgeInsets.symmetric(horizontal: 16),child: MarkdownBody(data: article.description)),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 56,
                color: Pallet.colorWhite,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_left_rounded),
                          SizedBox(
                            width: 4,
                          ),
                          AppFontsStyle.getAppTextView("Go Back", size: 16)
                        ],
                      ),
                    ),
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
                          height: 16,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
