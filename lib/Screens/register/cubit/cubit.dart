// ignore_for_file: non_constant_identifier_names, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:e_commerce_training/Screens/register/cubit/state.dart';
import 'package:e_commerce_training/model/login/login_model.dart';
import 'package:e_commerce_training/network/End_Points.dart';
import 'package:e_commerce_training/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);


  LoginModel loginModel;
  void UserRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
    @required String image,
  })

  {

    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'image': image,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangePassword()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordRegisterState());
  }
}
