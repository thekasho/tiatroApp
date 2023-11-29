part of '../widgets.dart';

class AccountTextForm extends StatelessWidget {

  final TextEditingController controller;
  final String? Function(String?) valid;
  final String hintText;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  
  const AccountTextForm({super.key, required this.controller, required this.valid, required this.hintText, this.prefixIcon, this.prefixIconColor, this.focusNode, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      child: TextFormField(
        enableInteractiveSelection: false,
        controller: controller,
        validator: valid,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: false,
        cursorColor: formFillColor,
        style: TextStyle(
          fontSize: 18.sp,
          color: kColorFontLight,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14.sp,
              color: hintGray,
              fontFamily: 'Cairo'
          ),
          errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 13.sp,
              fontFamily: 'Cairo'
          ),
          filled: true,
          fillColor: formFillColor,
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 2.w, vertical: 1.h
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0, color: formFillColor
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: appTextColorPrimary),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: red),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 0.5, color: red),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class AccountSubmitButton extends StatelessWidget {

  final String title;
  final void Function()? onPressed;
  final FocusNode? focusNode;

  const AccountSubmitButton({
    super.key,
    required this.title,
    this.onPressed, this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return  Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialButton(
        focusNode: focusNode,
        onPressed: onPressed,
        focusColor: yellowStarLight,
        focusElevation: 10,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: .5.h, horizontal: 5.w
        ),
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