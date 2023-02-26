import 'package:dio/dio.dart';
import 'package:qiita_app/api/responses/article_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client_provider.dart';

part 'article_api.g.dart';

@RestApi()
abstract class ArticleApi {
  factory ArticleApi(Dio dio) = _ArticleApi;

  @GET("/items")
  Future<List<ArticleResponse>> getArticles(
    @Query("page") int page,
    @Query("per_page") int perPage,
  );

  @GET("/items/{id}")
  Future<ArticleResponse> getArticle(@Path("id") String id);
}

@riverpod
ArticleApi articleApi(ArticleApiRef ref) =>
    ArticleApi(ref.watch(apiClientProvider));

@riverpod
Future<List<ArticleResponse>> getArticleResponses(
        GetArticleResponsesRef ref, int page, int perPage) =>
    ref.watch(articleApiProvider).getArticles(page, perPage);

@riverpod
Future<ArticleResponse> getArticleResponse(
        GetArticleResponseRef ref, String id) =>
    ref.watch(articleApiProvider).getArticle(id);
