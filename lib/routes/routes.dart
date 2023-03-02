import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:qiita_app/pages/archive_page.dart';
import 'package:qiita_app/pages/article_page.dart';
import 'package:qiita_app/pages/detail_page.dart';

part 'routes.g.dart';

@TypedGoRoute<ArticlesRoute>(path: '/')
@immutable
class ArticlesRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: const ArticlePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}

@TypedGoRoute<ArchivesRoute>(path: '/archives')
@immutable
class ArchivesRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: const ArchivePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}

@TypedGoRoute<DetailRoute>(path: '/articles/:id')
@immutable
class DetailRoute extends GoRouteData {
  const DetailRoute({required this.id});
  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        key: state.pageKey,
        child: DetailPage(id: id),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}
