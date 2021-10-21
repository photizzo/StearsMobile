import 'package:bawo/data/cache/user.cache.dart';
import 'package:bawo/data/core/table_constants.dart';
import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:hive/hive.dart';

class UserCacheImpl extends UserCache {
  @override
  Future<List<Article>> getFavoriteArticles() async {
    final box = await Hive.openBox<Article>(DbTable.ARTICLE_TABLE_NAME);
    final data = box.values;
    final favoriteList = data.toSet().toList();
    return favoriteList;
  }

  @override
  Future<void> saveFavoriteArticle(Article article) async {
    var box = await Hive.openBox<Article>(DbTable.ARTICLE_TABLE_NAME);
    box.put(article.id, article);
  }

  @override
  Future<void> removeFavoriteArticle(Article article) async {
    var box = await Hive.openBox<Article>(DbTable.ARTICLE_TABLE_NAME);
    box.delete(article.id);
  }
}
