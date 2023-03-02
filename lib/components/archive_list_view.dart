import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/application/article.dart';
import 'package:qiita_app/components/article_card.dart';
import 'package:qiita_app/components/error_view.dart';
import 'package:qiita_app/components/progress_view.dart';

class ArchiveListView extends HookConsumerWidget {
  const ArchiveListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(archiveIdsProvider);
    return asyncData.when(
      data: (articleIds) => _ArchiveListView(articleIds: articleIds),
      error: (_, __) => const ErrorView(text: "エラーが発生しました"),
      loading: () => const ProgressView(),
    );
  }
}

class _ArchiveListView extends HookConsumerWidget {
  const _ArchiveListView({required this.articleIds});

  final List<String> articleIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: articleIds.length,
      itemBuilder: (_, index) {
        return ProviderScope(
          overrides: [articleIdProvider.overrideWith((_) => articleIds[index])],
          child: const ArticleCard(),
        );
      },
    );
  }
}
