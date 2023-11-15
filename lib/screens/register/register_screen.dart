// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/screens/register/register_cubit/cubit.dart';
import 'package:online_groceries/screens/register/register_cubit/states.dart';

import '../../layout/home_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login_screen/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value)
            {
              navigateTo(context, const Verification());
              print(FirebaseAuth.instance.currentUser?.email);
              showToast(message: 'Check your mail', state: ToastState.success);
            }).catchError((error)
            {
              showToast(message: error.toString(), state: ToastState.error);
            });
          }
          if(state is RegisterErrorState){
            showToast(message: state.error.toString(), state: ToastState.error);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'Register now to browse our hot offers',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name!';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Email Address!';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextField(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          controller: passwordController,
                          isPassword: cubit.isPassword,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short!';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefixIcon: Icons.lock,
                          onPressedSuffix: () {
                            cubit.changePasswordVisibility();
                          },
                          suffix: cubit.suffix,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Phone Number!';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                  FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value)
                                  {
                                    showToast(message: 'Check your mail', state: ToastState.success);
                                  }).catchError((error)
                                  {

                                  });
                                }
                              },
                              text: 'register',
                              radius: 10.0),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'have an account ! ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            defaultTextButton(
                              onPressed: () {
                                Navigator.pop(context, const LoginScreen());
                              },
                              text: 'Login',
                            )
                          ],
                        )
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






class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {

      },
        builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'We have sent a verification email to:',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                Text(
                  '${FirebaseAuth.instance.currentUser?.email}',
                  style: const TextStyle(
                      fontSize: 18
                  ),),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'click the link in your email to verify your account',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                  ),),
                const SizedBox(
                  height: 10,
                ),
                defaultButton(
                    function: () async {
                      await FirebaseAuth.instance.currentUser?.reload();
                      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
                        CacheHelper.setData
                          (
                          key: 'uId',
                          value:FirebaseAuth.instance.currentUser?.uid,
                        ).then((value) {
                          navigateAndFinish(context, const HomeLayout());

                        });
                        showToast(
                            message: 'Verified successfully',
                            state: ToastState.success
                        );
                        setState(() {
                          uId = CacheHelper.getData(key: 'uId');
                        });
                      }
                    },
                    text: 'continue',isUpperCase: true
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'If you can\'t find it',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey
                      ),),
                    defaultTextButton(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value)
                          {
                            showToast(message: 'Check your mail', state: ToastState.success);
                          }).catchError((error)
                          {
                            print(error.toString());
                          });
                        }, text: 'click here to resend')
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
