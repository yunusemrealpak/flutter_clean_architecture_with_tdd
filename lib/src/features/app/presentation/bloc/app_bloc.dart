import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  TabsRouter? _tabsRouter;

  AppBloc() : super(const AppInitialState()) {
    on<AppInitialize>(_onInitialize);
    on<AppNavigateToTab>(_onNavigateToTab);
    on<AppRefresh>(_onRefresh);
    on<AppLogout>(_onLogout);
    on<AppSetTabsRouter>(_onSetTabsRouter);
  }

  void setTabsRouter(TabsRouter router) {
    add(AppSetTabsRouter(router));
  }

  void _onSetTabsRouter(AppSetTabsRouter event, Emitter<AppState> emit) {
    _tabsRouter = event.router;
    if (state is AppNavigationState) {
      final currentState = state as AppNavigationState;
      _tabsRouter?.setActiveIndex(currentState.currentIndex);
    }
  }

  void _onInitialize(AppInitialize event, Emitter<AppState> emit) {
    emit(const AppNavigationState(currentIndex: 0));
  }

  void _onNavigateToTab(AppNavigateToTab event, Emitter<AppState> emit) {
    if (state is AppNavigationState) {
      final currentState = state as AppNavigationState;
      emit(currentState.copyWith(
        currentIndex: event.tabIndex,
        isLoading: false,
        error: null,
      ));
      _tabsRouter?.setActiveIndex(event.tabIndex);
    }
  }

  void _onRefresh(AppRefresh event, Emitter<AppState> emit) async {
    if (state is AppNavigationState) {
      final currentState = state as AppNavigationState;
      emit(currentState.copyWith(isLoading: true));

      try {
        // Burada gerekli refresh işlemleri yapılabilir
        await Future.delayed(const Duration(seconds: 1));
        emit(currentState.copyWith(isLoading: false));
      } catch (e) {
        emit(AppErrorState(e.toString()));
      }
    }
  }

  void _onLogout(AppLogout event, Emitter<AppState> emit) async {
    try {
      // Burada logout işlemleri yapılabilir
      emit(const AppInitialState());
    } catch (e) {
      emit(AppErrorState(e.toString()));
    }
  }
}
