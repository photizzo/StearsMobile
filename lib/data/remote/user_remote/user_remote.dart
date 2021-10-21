import 'dart:convert';
abstract class UserRemote{
  // Future<List<EventData>?> getEventsNearMe(String lng, String lat, TokenMetaData tokenMetaData);
}

void handleError(dynamic error) {
  var errorString = error.response.toString();
  var json = jsonDecode(errorString);
  var nameJson = json['message'];
  throw nameJson;
}
