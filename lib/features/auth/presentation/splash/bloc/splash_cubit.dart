import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notesapp/features/auth/domain/usecases/get_logged_in_user_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetLoggedInUserUseCase _loggedInUserUseCase;

  SplashCubit(this._loggedInUserUseCase) : super(SplashInitial());

  Future<void> checkLoggedInUser() async {
    emit(SplashLoading());
    final result = await _loggedInUserUseCase(null);
    result.fold(
      (value) => emit(SplashLoggedIn()),
      (exception) => emit(SplashNotLoggedIn()),
    );
  }
}
