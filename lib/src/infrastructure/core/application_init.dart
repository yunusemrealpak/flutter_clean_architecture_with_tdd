import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/infrastructure/di/injection_container.dart';

class ApplicationInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initDependencies();
  }

  static Future<void> _initDependencies() async {
    await InjectionContainer.configureDependencies();
  }
}
