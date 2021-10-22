
import 'package:bawo/data/remote/models/article/articles.dart';

abstract class UserRepository {
  Future<List<Article>?> getRecentArticles();
  Future<List<Article>> getFavoriteArticles();
  Future<void> saveFavoriteArticle(Article article);
  Future<void> removeFavoriteArticle(Article article);
}