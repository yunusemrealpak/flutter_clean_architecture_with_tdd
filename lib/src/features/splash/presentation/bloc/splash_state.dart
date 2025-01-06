part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}

class RequiresUpdate extends SplashState {
  final bool forceUpdate;

  const RequiresUpdate({required this.forceUpdate});

  @override
  List<Object> get props => [forceUpdate];
}

class NavigateToAuth extends SplashState {}

class NavigateToHome extends SplashState {}
