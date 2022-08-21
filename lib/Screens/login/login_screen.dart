// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:e_commerce_training/Screens/login/cubit/cubit.dart';
import 'package:e_commerce_training/Screens/register/register_screen.dart';
import 'package:e_commerce_training/layout/home_screen.dart';
import 'package:e_commerce_training/network/cache_helper.dart';
import 'package:e_commerce_training/shared/componnetns/components.dart';
import 'package:e_commerce_training/shared/componnetns/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginCubit(),
      child: BlocConsumer<loginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              ShowToast(
                text: state.loginModel.message,
                state: ToastStates.SUCCESS,
              );
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                      key: "token", value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, HomeScreen());
              });
            } else {
              ShowToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Login Now to get our hot offers!",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefix: Icons.email,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          label: 'Email',
                          hint: 'Enter your email',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          prefix: Icons.key,
                          suffix: loginCubit.get(context).suffix,
                          isPassword: loginCubit.get(context).isPassword,
                          suffixPressed: () {
                            loginCubit.get(context).ChangePassword();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          label: 'Password',
                          hint: 'Enter your password',
                        ),
                        defaultTextButton(
                          function: () {},
                          text: "Forgotten password?",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Center(
                            child: defaultMaterialButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  loginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',
                              radius: 20,
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Register Now!',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/icon/google.svg',
                                    fit: BoxFit.none,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/icon/facebook.svg',
                                    fit: BoxFit.none,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: InkWell(
                                  child: SvgPicture.asset(
                                    'assets/icon/twitter.svg',
                                    fit: BoxFit.none,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}