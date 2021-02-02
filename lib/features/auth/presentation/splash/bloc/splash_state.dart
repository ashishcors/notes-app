part of 'splash_cubit.dart';

abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLoggedIn extends SplashState {
  const SplashLoggedIn();
}

class SplashNotLoggedIn extends SplashState {
  const SplashNotLoggedIn();
}
