import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../infrastructure/router/app_router.gr.dart';
import '../bloc/splash_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is RequiresUpdate) {
          // TODO: Show update dialog
        } else if (state is NavigateToAuth) {
          // TODO: Auth route will be implemented
          // context.router.replace(const LoginRoute());
        } else if (state is NavigateToHome) {
          context.router.replace(const AppRoute());
        } else if (state is SplashError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
