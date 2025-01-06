import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../infrastructure/router/app_router.gr.dart';
import '../bloc/app_bloc.dart';

@RoutePage()
class AppRoute extends StatelessWidget {
  const AppRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AppBloc>(),
      child: AutoTabsRouter(
        routes: const [
          HomeTabRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          context.read<AppBloc>().setTabsRouter(context.tabsRouter);

          return BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return Scaffold(
                body: child,
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state is AppNavigationState
                      ? state.currentIndex
                      : context.tabsRouter.activeIndex,
                  onTap: (index) {
                    context.read<AppBloc>().add(AppNavigateToTab(index));
                  },
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
