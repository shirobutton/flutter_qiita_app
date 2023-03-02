import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/api/article_api.dart';
import 'package:qiita_app/application/article.dart';
import 'package:qiita_app/data/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'article_page.g.dart';

const _itemsPerPage = 20;

final _articlePageCountProvider = StateProvider.autoDispose((ref) => 1);

@riverpod
void Function() refresh(RefreshRef ref) => () {
      ref.invalidate(getArticleResponsesProvider);
      ref.invalidate(_articlePageCountProvider);
    };

@riverpod
bool articlesIsLoadedOut(ArticlesIsLoadedOutRef ref) {
  final result = ref.watch(articleMapProvider);
  final pageCount = ref.read(_articlePageCountProvider);
  final articles = result.valueOrNull;

  return articles == null
      ? false
      : articles.length < (pageCount * _itemsPerPage);
}

@riverpod
void Function() loadMoreArticles(LoadMoreArticlesRef ref) => () {
      ref.read(_articlePageCountProvider.notifier).state++;
    };

@riverpod
Future<Map<String, Article>> articleMap(ArticleMapRef ref) {
  final pageCount = ref.watch(_articlePageCountProvider);
  final futures = List.generate(
    pageCount,
    (page) => ref.watch(getArticlesProvider(page + 1, _itemsPerPage).future),
  );
  return Future.wait(futures).then((nest) => Map.fromEntries(
      nest.expand((list) => list).map((e) => MapEntry(e.id, e))));
}

@riverpod
Future<List<String>> articleIds(ArticleIdsRef ref) =>
    ref.watch(articleMapProvider.selectAsync((data) => data.keys.toList()));

@riverpod
Future<Article> article(ArticleRef ref, String id) async {
  final archive = await ref.watch(getArchivedArticleProvider(id).future);
  if (archive != null) return archive;
  final cache =
      await ref.watch(articleMapProvider.selectAsync((list) => list[id]));
  if (cache != null) return cache;
  return ref.watch(getArticleProvider(id).future);
}
