import 'dart:convert';

import 'package:bawo/data/remote/models/article/articles.dart';
abstract class UserRemote{
  Future<List<Article>?> getRecentArticles();
}

void handleError(dynamic error) {
  var errorString = error.response.toString();
  var json = jsonDecode(errorString);
  var nameJson = json['message'];
  throw nameJson;
}
