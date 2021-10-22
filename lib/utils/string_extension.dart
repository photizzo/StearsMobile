import 'package:intl/intl.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get formatNull => this.toLowerCase() == "null" ? "Not Available" : this;
  String get formatNullNA => this.toLowerCase() == "null" ? "NA" : this;
  String get allInCaps => this.toUpperCase();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String toLowerCase(String s) => s[0].toLowerCase() + s.substring(1);
  String get capitalizeFirstOfEach => this.split(" ").map((str) => str.capitalize).join(" ");
  String capitalizeString() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  String? toTitleCase() {
    return _convertToTitleCase(this);
  }

  String? _convertToTitleCase(String text) {
    if (text == null) {
      return null;
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  /// Formats string type yyyy-mm-dd hh:mm
  /// to date object
  DateTime formatStringDateType1(){
    final dateFormat = new DateFormat('yyyy-MM-dd hh:mm');
    var inputDate = dateFormat.parse(this); // <-- Incoming date
    return inputDate;
  }
  /// Formats string type yyyy/mm/dd
  /// to date object
  DateTime formatStringDateType2(){
    final dateFormat = new DateFormat('yyyy/MM/dd');
    var inputDate = dateFormat.parse(this); // <-- Incoming date
    return inputDate;
  }
    DateTime formatStringDateType3(){
    final dateFormat = new DateFormat('yyyy-MM-ddThh:mm');
    var inputDate = dateFormat.parse(this); // <-- Incoming date
    return inputDate;
  }
}