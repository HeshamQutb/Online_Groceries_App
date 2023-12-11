import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/root_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'login_cubit/cubit.dart';
import 'login_cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(message: state.error, state: ToastState.error);
          }
          if (state is LoginSuccessState) {
            CacheHelper.setData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(
                context,
                const RootLayout(),
              );
            });
            showToast(
              message: 'Successfully Login',
              state: ToastState.success,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Image.asset(
                            'assets/images/otp.jpg',
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Login ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Enter your email and password!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                          height: 20,
                        ),
                        defaultTextField(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            defaultTextButton(
                                onPressed: () {},
                                text: 'Forgot Password?',
                                isUpperCase: false),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Login'),
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account !',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            defaultTextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                text: 'signup')
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
