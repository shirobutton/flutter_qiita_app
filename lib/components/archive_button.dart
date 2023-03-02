import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/application/article.dart';
import 'package:qiita_app/data/article.dart';

class ArchiveButton extends HookConsumerWidget {
  const ArchiveButton({super.key, required Article article})
      : _article = article;

  final Article _article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      iconSize: 32,
      color: _article.isArchived ? Colors.red : Colors.grey,
      isSelected: _article.isArchived,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
      ),
      icon: const Icon(Icons.archive_outlined),
      selectedIcon: const Icon(Icons.archive),
      onPressed: () {
        if (_article.isArchived) {
          ref.read(deleteArchivedArticleProvider(_article.id));
        } else {
          ref.read(archiveArticleProvider(_article));
        }
      },
    );
  }
}
