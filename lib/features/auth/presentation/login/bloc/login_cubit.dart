import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/features/auth/domain/usecases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  Future<void> login() async {
    final email = emailTextController.text;
    final password = passwordTextController.text;

    if (email == null || email.isEmpty) {
      emit(LoginError("Email is required"));
      return null;
    }

    if (password == null || password.isEmpty) {
      emit(LoginError("Password is required"));
      return null;
    }

    emit(LoginLoading());
    final result = await _loginUseCase(LoginParams(email, password));
    result.fold(
      (value) => emit(LoginSuccess()),
      (exception) => emit(LoginError(exception.toString())),
    );
  }
}
