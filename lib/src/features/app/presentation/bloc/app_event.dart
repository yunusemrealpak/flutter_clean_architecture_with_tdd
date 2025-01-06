part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppNavigateToTab extends AppEvent {
  final int tabIndex;

  const AppNavigateToTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}

class AppSetTabsRouter extends AppEvent {
  final TabsRouter router;

  const AppSetTabsRouter(this.router);

  @override
  List<Object> get props => [router];
}

class AppInitialize extends AppEvent {
  const AppInitialize();
}

class AppRefresh extends AppEvent {
  const AppRefresh();
}

class AppLogout extends AppEvent {
  const AppLogout();
}
