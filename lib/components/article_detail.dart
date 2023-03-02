import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qiita_app/application/article_page.dart';
import 'package:qiita_app/components/archive_button.dart';
import 'package:qiita_app/components/article_info.dart';
import 'package:qiita_app/components/progress_view.dart';
import 'package:qiita_app/data/article.dart';

class ArticleDetail extends HookConsumerWidget {
  const ArticleDetail({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(articleProvider(id));
    if (asyncData.hasError) context.pop();
    return asyncData.maybeWhen(
      data: (article) => _ArticleDetail(article: article),
      orElse: () => const ProgressView(),
    );
  }
}

class _ArticleDetail extends HookConsumerWidget {
  const _ArticleDetail({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Gap(4),
                  Expanded(
                    child: ArticleInfo(article: article),
                  ),
                  ArchiveButton(article: article),
                  const Gap(4),
                ],
              ),
            ),
          ),
          const Gap(16),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Html(data: article.body),
            ),
          ),
        ],
      ),
    );
  }
}
