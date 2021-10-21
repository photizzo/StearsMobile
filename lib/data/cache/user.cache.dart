
import 'package:bawo/data/remote/models/article/articles.dart';

abstract class UserCache {
  Future<List<Article>> getFavoriteArticles();
  Future<void> saveFavoriteArticle(Article article);
  Future<void> removeFavoriteArticle(Article article);
}