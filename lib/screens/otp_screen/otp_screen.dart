// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';
import 'otp_cubit/cubit.dart';
import 'otp_cubit/states.dart';

class EnterPhoneNumberScreen extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PhoneAuthCubit cubit = PhoneAuthCubit();

  EnterPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset('assets/images/shopping.png'),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Get your groceries with Groc',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultTextField(
                        controller: phoneNumberController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone Number must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefixIcon: IconBroken.Call,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.submitPhoneNumber(phoneNumberController.text);
                            navigateTo(context, EnterOTPCodeScreen(cubit.verificationId));
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.submitPhoneNumber(phoneNumberController.text);
                            navigateTo(context, EnterOTPCodeScreen(cubit.verificationId));
                          }
                        },
                        text: 'Submit',
                      ),
                    ],
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



class EnterOTPCodeScreen extends StatelessWidget {
  final String? verificationId;
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PhoneAuthCubit cubit = PhoneAuthCubit();

  EnterOTPCodeScreen(this.verificationId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset('assets/images/shopping.png'),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Enter The code',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        controller: codeController,
                        cursorHeight: 19,
                        enableActiveFill: true,
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 50,
                          inactiveColor: Colors.grey,
                          selectedColor: Colors.lightBlue,
                          activeFillColor: Colors.blue,
                          selectedFillColor: Colors.blue,
                          inactiveFillColor: Colors.grey.shade500,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.submitOTP(codeController.text);
                            navigateAndFinish(context, const HomeLayout());
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.submitOTP(codeController.text);
                            navigateAndFinish(context, const HomeLayout());
                          }
                        },
                        text: 'Submit',
                      ),
                    ],
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




