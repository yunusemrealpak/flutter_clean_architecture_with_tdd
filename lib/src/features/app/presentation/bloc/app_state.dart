part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppInitialState extends AppState {
  const AppInitialState();
}

class AppNavigationState extends AppState {
  final int currentIndex;
  final bool isLoading;
  final String? error;

  const AppNavigationState({
    required this.currentIndex,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [currentIndex, isLoading, error];

  AppNavigationState copyWith({
    int? currentIndex,
    bool? isLoading,
    String? error,
  }) {
    return AppNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AppErrorState extends AppState {
  final String message;

  const AppErrorState(this.message);

  @override
  List<Object> get props => [message];
}
