// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/screens/register/register_cubit/states.dart';


import '../../../models/user_model.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String email,
    required String name,
    required String password,
    required String phone,
  }){
    emit(RegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      userCreate(
          email: email,
          name: name,
          password: password,
          phone: phone,
          uId: value.user!.uid
      );
      print(value.user?.email);
      print(value.user?.uid);
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }


  void userCreate({
    required String email,
    required String name,
    required String password,
    required String phone,
    required String uId,
    String? bio,
    String? image,
    String? cover,
}){
    UserModel model = UserModel(
        name = name,
        phone = phone,
        email = email,
        uId = uId,
        bio = 'add bio here ... ',
        image = 'https://img.freepik.com/free-icon/man_318-677829.jpg',
        cover = 'https://cdn.vectorstock.com/i/preview-1x/65/30/default-image-icon-missing-picture-page-vector-40546530.jpg',
    );
    
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()
    ).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error){
      emit(CreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword == true ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }
}


