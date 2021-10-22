import 'package:hive/hive.dart';

part 'articles.g.dart';

@HiveType(typeId: 1)
class Article {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String date;
  @HiveField(3)
  String minRead;
  @HiveField(4)
  String imageUrl;
  @HiveField(5)
  bool isBookmarked = false;
  @HiveField(6)
  String description;
  @HiveField(7)
  Author author;
  @HiveField(8)
  DateTime createdAt;
  @HiveField(9)
  DateTime addedAt;

  Article(this.id, this.title, this.date, this.minRead, this.imageUrl,
      this.isBookmarked, this.description, this.author, this.createdAt, this.addedAt);
}

@HiveType(typeId: 2)
class Author {
  @HiveField(0)
  String name;
  @HiveField(1)
  String avatar;

  Author(this.name, this.avatar);
}