part of 'widgets.dart';

class AppBarSettings extends StatelessWidget {
  const AppBarSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      color: Colors.transparent,
      child: Row(
        children: [
          Image(
            width: 0.4.dp,
            height: 0.4.dp,
            image: const AssetImage(kIconSplash),
          ),
          SizedBox(width: 1.w),
          Text(
            "Settings",
            style: Get.textTheme.headlineMedium,
          ),
          Container(
            width: 1,
            height: 8.h,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            color: kColorHint,
          ),
          Icon(
            FontAwesomeIcons.gear,
            size: 20.sp,
            color: Colors.white,
          ),
          const Spacer(),
          IconButton(
            focusColor: kColorFocus,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              FontAwesomeIcons.chevronRight,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}