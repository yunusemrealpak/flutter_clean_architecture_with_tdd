// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter_clean_architecture/src/features/app/presentation/pages/app_page.dart'
    as _i2;
import 'package:flutter_clean_architecture/src/features/splash/presentation/pages/splash_page.dart'
    as _i3;
import 'package:flutter_clean_architecture/src/infrastructure/router/tab_routers.dart'
    as _i1;

/// generated route for
/// [_i1.AnalyzeTabPage]
class AnalyzeTabRoute extends _i4.PageRouteInfo<void> {
  const AnalyzeTabRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AnalyzeTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalyzeTabRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AnalyzeTabPage();
    },
  );
}

/// generated route for
/// [_i2.AppRoute]
class AppRoute extends _i4.PageRouteInfo<void> {
  const AppRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppRoute();
    },
  );
}

/// generated route for
/// [_i1.HomeTabPage]
class HomeTabRoute extends _i4.PageRouteInfo<void> {
  const HomeTabRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeTabRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeTabPage();
    },
  );
}

/// generated route for
/// [_i1.LeaderboardTabPage]
class LeaderboardTabRoute extends _i4.PageRouteInfo<void> {
  const LeaderboardTabRoute({List<_i4.PageRouteInfo>? children})
      : super(
          LeaderboardTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaderboardTabRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.LeaderboardTabPage();
    },
  );
}

/// generated route for
/// [_i1.ProfileTabPage]
class ProfileTabRoute extends _i4.PageRouteInfo<void> {
  const ProfileTabRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ProfileTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTabRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.ProfileTabPage();
    },
  );
}

/// generated route for
/// [_i3.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashPage();
    },
  );
}
