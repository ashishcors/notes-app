import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/features/auth/presentation/splash/bloc/splash_cubit.dart';
import 'package:notesapp/src/locator.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/widgets/app_logo.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = locator<SplashCubit>();
    bloc.checkLoggedInUser();
    return BlocProvider<SplashCubit>(
      create: (context) => bloc,
      child: Scaffold(
        body: _SplashPageLayout(),
      ),
    );
  }
}

class _SplashPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) => {
        if (state is SplashLoggedIn)
          {locator<NavigationService>().navigateToClearStack(homeRoute)}
        else if (state is SplashNotLoggedIn)
          {locator<NavigationService>().navigateToClearStack(loginRoute)}
      },
      child: Scaffold(
        body: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
