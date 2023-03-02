import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:qiita_app/application/article_page.dart';
import 'package:qiita_app/components/article_card.dart';
import 'package:qiita_app/components/error_view.dart';
import 'package:qiita_app/components/progress_view.dart';
import 'package:qiita_app/hooks/use_paging_controller.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleIds = ref.watch(articleIdsProvider);
    final isLast = ref.watch(articlesIsLoadedOutProvider);
    final loadMore = ref.watch(loadMoreArticlesProvider);
    final pagingController = usePagingController(
      itemList: articleIds.valueOrNull,
      isLast: isLast,
      loadMore: loadMore,
      error: articleIds.error,
    );
    final refresh = ref.refresh(refreshProvider);

    return RefreshIndicator(
      onRefresh: () async {
        refresh();
      },
      child: PagedListView.separated(
        pagingController: pagingController,
        separatorBuilder: (context, index) => const Divider(),
        builderDelegate: PagedChildBuilderDelegate<String>(
          itemBuilder: (context, id, index) => ProviderScope(
            overrides: [articleIdProvider.overrideWith((_) => id)],
            child: const ArticleCard(),
          ),
          firstPageErrorIndicatorBuilder: (_) => ErrorView(
            text: "ネットワークエラーが発生しました",
            retry: refresh,
          ),
          newPageProgressIndicatorBuilder: (_) => const ProgressView(),
          noItemsFoundIndicatorBuilder: (_) => ErrorView(
            text: "記事が取得できませんでした",
            retry: refresh,
            enableRetryButton: true,
          ),
        ),
      ),
    );
  }
}
