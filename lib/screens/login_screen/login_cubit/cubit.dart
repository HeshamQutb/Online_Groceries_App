// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/screens/login_screen/login_cubit/states.dart';
import '../../../shared/network/local/cache_helper.dart';



class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      CacheHelper.setData(
          key: 'uId',
          value:value.user?.uid
      );
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      emit(LoginErrorState(error.toString()));
    });

  }



  bool isPassword = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword == true ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }


}