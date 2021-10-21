import 'package:bawo/data/cache/user.cache.dart';
import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:bawo/data/remote/user_remote/user_remote.dart';
import 'package:bawo/data/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemote userRemote;
  final UserCache userCache;

  UserRepositoryImpl(this.userRemote, this.userCache);

  @override
  Future<List<Article>> getFavoriteArticles() {
    return userCache.getFavoriteArticles();
  }

  @override
  Future<List<Article>> getRecentArticles() {
    // TODO: implement getRecentArticles
    throw UnimplementedError();
  }

  @override
  Future<void> saveFavoriteArticle(Article article) {
    return userCache.saveFavoriteArticle(article);
  }

  @override
  Future<void> removeFavoriteArticle(Article article) {
    return userCache.removeFavoriteArticle(article);
  }
}
