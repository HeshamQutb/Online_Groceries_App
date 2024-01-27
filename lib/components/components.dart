import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared/styles/colors.dart';
import '../shared/styles/icon_broken.dart';



MaterialColor createCustomMaterialColor(Color color) {
  Map<int, Color> swatch = <int, Color>{};
  for (int i = 50; i <= 900; i += 100) {
    swatch[i] = color;
  }
  return MaterialColor(color.value, swatch);
}

// Usage:
Color customColor = const Color(0xFF53b175);
MaterialColor customMaterialColor = createCustomMaterialColor(customColor);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget)
);


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false
);


Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  IconData? icon,
  required void Function()? function,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0
}) => Container(
  width: width,
  decoration: BoxDecoration(
      color: background,
    borderRadius: BorderRadius.circular(radius)
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
        isUpperCase == true ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white
      ),
    ),
  ),
);




Widget defaultButtonWithIcon({
  double width = double.infinity,
  Color background = defaultColor,
  IconData? icon,
  Color textColor = Colors.white,
  Color? iconColor,
  required void Function()? function,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0
}) => Container(
  width: width,
  decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius)
  ),
  child: MaterialButton(
    onPressed: function,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,color: iconColor,),
        const SizedBox(width: 8,),
        Text(
          isUpperCase == true ? text.toUpperCase() : text,
          style: TextStyle(
              color: textColor
          ),
        ),
      ],
    ),
  ),
);



Widget defaultTextButton({
  required void Function()? onPressed,
  required String text,
  bool isUpperCase = true,
  VisualDensity? visualDensity,
  double? size

}) => TextButton(
  style: TextButton.styleFrom(fixedSize: const Size.fromHeight(0.0)),
  onPressed: onPressed,
  child: Text(
    isUpperCase == true ? text.toUpperCase() : text,
    style: TextStyle(
      fontSize: size
    ),
  ),
);



// Widget defaultTextField({
//   required TextEditingController controller,
//   required TextInputType type,
//   TextCapitalization? capitalization,
//   required String? Function(String?)? validate,
//   void Function(String)? onChanged,
//   void Function(String)? onFieldSubmitted,
//   required String label,
//   required IconData prefixIcon,
//   IconData? suffix,
//   void Function()? onPressedSuffix,
//   bool? isPassword
// }) => TextFormField(
//   controller: controller,
//   obscureText: isPassword == true ? true : false,
//   keyboardType: type,
//   textCapitalization: TextCapitalization.words,
//   validator: validate,
//   onFieldSubmitted: onFieldSubmitted,
//   onChanged: onChanged,
//   decoration: InputDecoration(
//     prefixIcon: Icon(prefixIcon),
//     label: Text(label),
//     border: const OutlineInputBorder(),
//     suffixIcon: IconButton(
//       onPressed: onPressedSuffix,
//       icon: Icon(suffix),
//     ),
//   ),
// );



Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  TextCapitalization? capitalization,
  required String? Function(String?)? validate,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  required String label,
  IconData? prefixIcon,
  IconData? suffix,
  void Function()? onPressedSuffix,
  bool? isPassword,
  double radius = 30.0,
  int? length
}) => TextFormField(
  controller: controller,
  obscureText: isPassword == true ? true : false,
  keyboardType: type,
  textCapitalization: capitalization ?? TextCapitalization.none,
  validator: validate,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: (value) {},
  decoration: InputDecoration(
    prefixIcon: Icon(prefixIcon),
    label: Text(label),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius)
    ),
    suffixIcon: IconButton(
      onPressed: onPressedSuffix,
      icon: Icon(suffix),
    ),
  ),
  maxLength: length,
);



void showToast({
  required String message,
  required ToastState state,
})=> Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: taostColor(state),
    textColor: Colors.white,
    fontSize: 16.0);


enum ToastState {
  success,error,warning
}

Color? taostColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.orange;
      break;

  }
  return color;





}


Widget divider() => Padding(
  padding: const EdgeInsets.only(left: 20),
  child:   Container(

    width: 1,

    height: 1,

    color: Colors.grey,

  ),
);


Widget defaultAppBar({
  required BuildContext context,
  String? title,
  bool? centerTitle,
  double? titleSpacing,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
      onPressed: (){
    Navigator.pop(context);
  },
      icon: const Icon(IconBroken.Arrow___Left_2)
  ),
  title: Text(title!),
  centerTitle: centerTitle,
  titleSpacing: titleSpacing,
  actions: actions,
);
