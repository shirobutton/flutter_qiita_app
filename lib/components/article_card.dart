import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/application/article_page.dart';
import 'package:qiita_app/components/archive_button.dart';
import 'package:qiita_app/components/article_info.dart';
import 'package:qiita_app/components/progress_view.dart';
import 'package:qiita_app/data/article.dart';
import 'package:qiita_app/routes/routes.dart';

final articleIdProvider = Provider<String>((_) {
  throw UnimplementedError();
});

class ArticleCard extends HookConsumerWidget {
  const ArticleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(articleIdProvider);
    final asyncData = ref.watch(articleProvider(id));
    return SizedBox(
      height: 148,
      child: asyncData.when(
        data: (article) => _ArticleCardView(article: article),
        error: (_, __) => const _ErrorCardView(),
        loading: () => const ProgressView(),
      ),
    );
  }
}

class _ArticleCardView extends StatelessWidget {
  const _ArticleCardView({required Article article}) : _article = article;

  final Article _article;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        DetailRoute(id: _article.id).push(context);
      },
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(4),
              Expanded(
                child: ArticleInfo(article: _article),
              ),
              ArchiveButton(article: _article),
              const Gap(4),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorCardView extends StatelessWidget {
  const _ErrorCardView();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Gap(4),
            Center(
              child: Icon(Icons.error_outline, size: 64, color: Colors.red),
            ),
            Center(child: Text("エラーが発生しました")),
            Gap(4),
          ],
        ),
      ),
    );
  }
}
