import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/api/article_api.dart';
import 'package:qiita_app/api/responses/article_response.dart';
import 'package:qiita_app/data/article.dart';
import 'package:qiita_app/database/article_entity.dart';
import 'package:qiita_app/database/article_entity_box.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article.g.dart';

@riverpod
Future<Article> getArticle(GetArticleRef ref, String id) async {
  final response = await ref.watch(getArticleResponseProvider(id).future);
  final isArchived = await ref.watch(
    _archiveMapProvider.selectAsync(
      (data) => data.containsKey(response.id),
    ),
  );
  return _fromResponce(response, isArchived);
}

@riverpod
Future<List<Article>> getArticles(
  GetArticlesRef ref,
  int page,
  int itemsPerPage,
) async {
  final articleReponses =
      await ref.watch(getArticleResponsesProvider(page, itemsPerPage).future);
  return Future.wait(
    articleReponses.map(
      (response) async => _fromResponce(
        response,
        await ref.watch(_archiveMapProvider
            .selectAsync((data) => data.containsKey(response.id))),
      ),
    ),
  );
}

final _archiveMapProvider = StreamProvider((ref) async* {
  final box = await ref.read(articleEntityBoxProvider.future);
  final stream = box.watch().map((event) => box.toMap());
  yield box.toMap();
  yield* stream;
});

@riverpod
Future<List<String>> archiveIds(ArchiveIdsRef ref) =>
    ref.watch(_archiveMapProvider
        .selectAsync((data) => data.keys.cast<String>().toList()));

@riverpod
Future<Article?> getArchivedArticle(GetArchivedArticleRef ref, String id) =>
    ref.watch(
      _archiveMapProvider.selectAsync((map) {
        final entity = map[id];
        if (entity == null) return null;
        return _fromEntity(entity);
      }),
    );

@riverpod
Future<void> archiveArticle(ArchiveArticleRef ref, Article article) =>
    ref.watch(articleEntityBoxProvider
        .selectAsync((box) => box.put(article.id, _toEntity(article))));

@riverpod
Future<void> deleteArchivedArticle(
  DeleteArchivedArticleRef ref,
  String id,
) =>
    ref.watch(articleEntityBoxProvider.selectAsync((box) => box.delete(id)));

ArticleEntity _toEntity(Article article) => ArticleEntity(
      id: article.id,
      title: article.title,
      body: article.body,
      userId: article.userId,
      userName: article.userName,
      userImageUrl: article.userImageUrl,
      likesCount: article.likesCount,
      stocksCount: article.stocksCount,
      tags: article.tags,
      createdAt: article.createdAt,
      updatedAt: article.updatedAt,
    );

Article _fromEntity(ArticleEntity entity) => Article(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      userId: entity.userId,
      userName: entity.userName,
      userImageUrl: entity.userImageUrl,
      likesCount: entity.likesCount,
      stocksCount: entity.stocksCount,
      tags: entity.tags,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isArchived: true,
    );

Article _fromResponce(
  ArticleResponse response,
  bool isArchived,
) =>
    Article(
      id: response.id,
      title: response.title,
      body: response.renderedBody,
      userId: response.user.id,
      userName: response.user.name,
      userImageUrl: response.user.imageUrl,
      likesCount: response.likesCount,
      stocksCount: response.stocksCount,
      tags: response.tags.map((e) => e.name).toList(),
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
      isArchived: isArchived,
    );
