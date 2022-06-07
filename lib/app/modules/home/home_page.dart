import 'package:flutter/material.dart';

import 'widgets/header_projects_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SafeArea(
        child: Drawer(
          child: ListTile(
            title: Text('Sair'),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Projetos'),
            expandedHeight: 100,
            toolbarHeight: 100,
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderProjectsMenu(),
          ),
        ],
      ),
    );
  }
}
