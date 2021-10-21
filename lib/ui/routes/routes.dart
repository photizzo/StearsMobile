import 'package:bawo/ui/articles/article_details_page.dart';
import 'package:bawo/ui/articles/home_page.dart';
import 'package:bawo/ui/route_error_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/home';
  static const articleDetails = '/article-details';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.articleDetails:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ArticleDetailsPage(settings.arguments),
          settings: settings,
          fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ErrorPage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
  }
}
