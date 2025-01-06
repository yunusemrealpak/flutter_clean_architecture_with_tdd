import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_app_version.dart';
import '../../domain/usecases/check_user_token.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAppVersion checkAppVersion;
  final CheckUserToken checkUserToken;

  SplashBloc({
    required this.checkAppVersion,
    required this.checkUserToken,
  }) : super(SplashInitial()) {
    on<CheckInitialSetup>(_onCheckInitialSetup);
  }

  Future<void> _onCheckInitialSetup(
    CheckInitialSetup event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    final versionResult = await checkAppVersion(NoParams());

    final versionState = versionResult.fold(
      (failure) => const SplashError('Versiyon kontrolü başarısız oldu'),
      (version) {
        if (version.currentVersion != version.minimumVersion) {
          return RequiresUpdate(forceUpdate: version.forceUpdate);
        }
        return null;
      },
    );

    if (versionState != null) {
      emit(versionState);
      return;
    }

    final tokenResult = await checkUserToken(NoParams());

    final tokenState = tokenResult.fold(
      (failure) => const SplashError('Token kontrolü başarısız oldu'),
      (hasToken) => hasToken ? NavigateToHome() : NavigateToAuth(),
    );

    emit(tokenState);
  }
}
