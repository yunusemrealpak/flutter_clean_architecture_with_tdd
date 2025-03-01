import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import './injection_container.config.dart';

@InjectableInit()
@immutable
final class InjectionContainer {
  static final GetIt _di = GetIt.I;

  static Future<void> configureDependencies() async => _di.init();
  static Future<void> resetDependencies() async => _di.reset(dispose: false);
  static T instance<T extends Object>() => _di.get<T>();
}

T di<T extends Object>() => InjectionContainer.instance<T>();
