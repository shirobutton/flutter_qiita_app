import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    required String body,
    required String userId,
    required String userName,
    required String userImageUrl,
    required int likesCount,
    required int stocksCount,
    required List<String> tags,
    required String createdAt,
    required String updatedAt,
    required bool isArchived,
  }) = _Article;
}
