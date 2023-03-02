import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'article_entity.dart';

part 'article_entity_box.g.dart';

@Riverpod(keepAlive: true)
Future<Box<ArticleEntity>> articleEntityBox(_) {
  Hive.registerAdapter(ArticleEntityAdapter());
  return Hive.openBox<ArticleEntity>('articleEntityBox');
}
