import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qiita_app/routes/routes.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  final routes = () {
    final articleRoute = ArticlesRoute();
    final archivesRoute = ArchivesRoute();
    return [
      _NavigationItem(
        go: articleRoute.go,
        location: articleRoute.location,
        item:
            const BottomNavigationBarItem(icon: Icon(Icons.list), label: "記事"),
      ),
      _NavigationItem(
        go: archivesRoute.go,
        location: archivesRoute.location,
        item: const BottomNavigationBarItem(
            icon: Icon(Icons.archive), label: "アーカイブ"),
      ),
    ];
  }();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: routes.map((route) => route.item).toList(),
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    final index = routes.lastIndexWhere((route) =>
        route.location != '/' && location.startsWith(route.location));
    return max(0, index);
  }

  void _onItemTapped(int index, BuildContext context) {
    routes[index].go(context);
  }
}

class _NavigationItem {
  _NavigationItem({
    required this.go,
    required this.location,
    required this.item,
  });
  final void Function(BuildContext context) go;
  final String location;
  final BottomNavigationBarItem item;
}
