import 'package:bawo/data/remote/user_remote/user_remote.dart';
import 'package:dio/dio.dart';

/**
 * This calls implements the UserRemote logic
 */
class UserRemoteImpl extends UserRemote {
  final Dio dioClient;

  UserRemoteImpl(this.dioClient);

  /*Future<List<InterestData>?> getCategories(TokenMetaData tokenMetaData) async {
    try {
      dioClient.options.headers['Authorization'] = tokenMetaData.token;
      var response = await dioClient.get(
        "${NetworkConfig.BASE_URL}/categories",
      );
      final responseData = CategoriesNetworkResponse.fromJson(response.data);
      return responseData.data;
    } catch (error) {
      handleError(error);
    }
  }
*/

}
