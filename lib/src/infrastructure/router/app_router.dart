import 'package:auto_route/auto_route.dart';
import 'package:flutter_clean_architecture/src/infrastructure/router/app_routes.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: AppRoutes.splash, page: SplashRoute.page, initial: true),
        AutoRoute(
          path: AppRoutes.app,
          page: AppRoute.page,
          children: [
            AutoRoute(path: AppRoutes.home, page: HomeTabRoute.page),
          ],
        ),
      ];
}
