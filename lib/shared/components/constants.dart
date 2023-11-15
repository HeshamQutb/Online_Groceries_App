// ignore_for_file: avoid_print
import '../../screens/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      navigateAndFinish(context, const LoginScreen());
    }
  });
}

String? uId;