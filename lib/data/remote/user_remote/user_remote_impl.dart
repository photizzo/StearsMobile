import 'package:bawo/data/core/network_config.dart';
import 'package:bawo/data/remote/models/article/article_network_response.dart';
import 'package:bawo/data/remote/models/article/articles.dart';
import 'package:bawo/data/remote/user_remote/user_remote.dart';
import 'package:dio/dio.dart';
import 'package:bawo/utils/string_extension.dart';

/**
 * This calls implements the UserRemote logic
 */
class UserRemoteImpl extends UserRemote {
  final Dio dioClient;

  UserRemoteImpl(this.dioClient);

  @override
  Future<List<Article>?> getRecentArticles() async {
    try {
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}/articles",
      );
      final responseData = ArticleNetworkResponse.fromJson(response.data);
      final list = responseData.data?.map((element) {
        return Article(
            element?.id ?? 0,
            element.title ?? "",
            "",
            "${element?.minRead} Min Read",
            element.imageUrl ?? "",
            false,
            element.description ?? "",
            Author(element.author ?? "", element.avatar ?? ""),
            element.createdAt?.formatStringDateType3() ?? DateTime.now(),
            DateTime.now());
      }).toList();
      return list ?? [];
    } catch (error) {
      handleError(error);
    }
  }
}
