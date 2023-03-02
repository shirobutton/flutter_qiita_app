import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_app/components/archive_list_view.dart';

class ArchivePage extends HookConsumerWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Qiita")),
      body: const ArchiveListView(),
    );
  }
}
