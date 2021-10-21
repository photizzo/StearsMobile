
import 'package:bawo/utils/sharedpreferences.dart';

/// create global instance of sharedPreferences global service
final SharedPreference sharedPreference = SharedPreference();

class Constant {
  static const String USER_ID_KEY = 'user_id';
}

extension StingExtentions on String {
 String get svg => 'assets/images/svg/$this.svg';
 String get png => 'assets/images/png/$this.png';
}
