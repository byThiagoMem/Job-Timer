import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import 'widgets/header_projects_menu.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state.status == HomesStatus.failure) {
          AsukaSnackbar.alert('Erro ao buscar os projetos').show();
        }
      },
      child: Scaffold(
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
            BlocSelector<HomeController, HomeState, bool>(
              selector: (state) => state.status == HomesStatus.loading,
              bloc: controller,
              builder: (context, showLoading) {
                return SliverVisibility(
                  visible: showLoading,
                  sliver: const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocSelector<HomeController, HomeState, List<ProjectModel>>(
              selector: (state) => state.projects,
              bloc: controller,
              builder: (context, projects) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    projects
                        .map((project) => ListTile(
                              title: Text(project.name),
                              subtitle: Text('${project.estimate}h'),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
