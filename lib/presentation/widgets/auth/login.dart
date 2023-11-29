part of '../widgets.dart';

class LoginTextForm extends StatelessWidget {

  final TextEditingController controller;
  final String? Function(String?) valid;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final bool isPassword;
  final double top;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;

  const LoginTextForm({
    super.key,
    required this.controller,
    required this.valid,
    required this.hintText,
    required this.top,
    required this.isPassword,
    this.prefixIcon,
    this.prefixIconColor, this.focusNode, this.onFieldSubmitted, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: top,
      ),

      width: 36.w,
      height: 20.h,

      child: TextFormField(
        enableInteractiveSelection: false,
        controller: controller,
        validator: valid,
        obscureText: isPassword,
        
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: false,
        
        cursorColor: formFillColor,
        keyboardType: TextInputType.visiblePassword,

        style: TextStyle(
          fontSize: 18.sp,
          color: kColorFontLight,
        ),

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 17.sp,
            color: hintGray,
            fontFamily: 'Cairo'
          ),

          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 15.sp,
            fontFamily: 'Cairo'
          ),

          filled: true,
          fillColor: formFillColor,

          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,

          suffixIcon: suffixIcon,

          contentPadding: EdgeInsets.symmetric(
              horizontal: 2.w, vertical: 1.h),

          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0, color: formFillColor
            ),
            borderRadius: BorderRadius.circular(30),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: appTextColorPrimary),
            borderRadius: BorderRadius.circular(30),
          ),

          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: red),
            borderRadius: BorderRadius.circular(30),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: red),
            borderRadius: BorderRadius.circular(30),
          ),

        ),
      ),
    );
  }
}


class LoginSubmitButton extends StatelessWidget {

  final String title;
  final void Function()? onPressed;
  final FocusNode? focusNode;

  const LoginSubmitButton({
    super.key,
    required this.title,
    this.onPressed, this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 3.h),
      child: MaterialButton(
        focusNode: focusNode,
        onPressed: onPressed,
        focusColor: yellowStarLight,
        focusElevation: 10,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        padding: EdgeInsetsDirectional.symmetric(
            vertical: 1.h, horizontal: 5.w),
        color: appTextColorPrimary,
        textColor: bg3,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}