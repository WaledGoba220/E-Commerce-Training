// ignore_for_file: unnecessary_import, non_constant_identifier_names, camel_case_types

import 'package:bloc/bloc.dart';
import 'package:e_commerce_training/Screens/login/cubit/state.dart';
import 'package:e_commerce_training/network/End_Points.dart';
import 'package:e_commerce_training/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/login/login_model.dart';

class loginCubit extends Cubit<LoginState> {
  loginCubit() : super(LoginInitialState());
  static loginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void UserLogin({@required String email, @required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordState());
  }
}
