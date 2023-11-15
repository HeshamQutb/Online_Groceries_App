// phone_auth_states.dart

import 'package:flutter/cupertino.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOccurred extends PhoneAuthState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class PhoneOTPVerified extends PhoneAuthState {}
