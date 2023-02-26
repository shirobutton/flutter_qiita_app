import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_app/api/responses/tag_response.dart';
import 'package:qiita_app/api/responses/user_response.dart';

part 'article_response.freezed.dart';
part 'article_response.g.dart';

@freezed
class ArticleResponse with _$ArticleResponse {
  const factory ArticleResponse({
    required String id,
    required String title,
    @JsonKey(name: 'rendered_body') required String renderedBody,
    @JsonKey(name: 'likes_count') required int likesCount,
    @JsonKey(name: 'stocks_count') required int stocksCount,
    required List<TagResponse> tags,
    required UserResponse user,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _ArticleResponse;

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);
}
