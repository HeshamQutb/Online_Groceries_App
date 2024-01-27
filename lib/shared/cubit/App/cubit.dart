// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries/shared/cubit/App/states.dart';


import '../../../components/components.dart';
import '../../../screens/login_screen/login_screen.dart';
import '../../network/local/cache_helper.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  void submit(context) {
    CacheHelper.setData(key: 'onBoarding', value: true).then((value)
    {
      if(value){
        navigateAndFinish(context,  const LoginScreen());
      }
      print('onBoarding = ${value.toString()}');
    });
  }


}
