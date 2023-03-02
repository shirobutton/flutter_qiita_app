import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/components/article_detail.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Qiita")),
      body: ArticleDetail(id: id),
    );
  }
}
