import 'package:hive/hive.dart';

part 'article_entity.g.dart';

@HiveType(typeId: 1)
class ArticleEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  @HiveField(3)
  String userId;
  @HiveField(4)
  String userName;
  @HiveField(5)
  String userImageUrl;
  @HiveField(6)
  int likesCount;
  @HiveField(7)
  int stocksCount;
  @HiveField(8)
  List<String> tags;
  @HiveField(9)
  String createdAt;
  @HiveField(10)
  String updatedAt;

  ArticleEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.likesCount,
    required this.stocksCount,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });
}
