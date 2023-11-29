part of '../widgets.dart';

class HomeTopBar extends StatelessWidget {

  final bool ButtonFocus;
  final IconData icon;
  final String title;
  final Future<void> Function()? OnPressed;

  const HomeTopBar({
    super.key,
    required this.ButtonFocus, this.OnPressed, required this.icon, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: OnPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
            horizontal: 1.5.w
          )),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(13.w, 3.h),
          ),
          backgroundColor: MaterialStateProperty.all<Color>( ButtonFocus == true ? white38 : bg2 ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 2.w, color: appTextColorPrimary),
            SizedBox(width: 0.6.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: appTextColorPrimary,
                fontFamily: 'Cairo'
              ),
            ),
          ],
        ),
      );
  }
}

class HomeAppBar extends StatelessWidget {
  final String userName;
  const HomeAppBar({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 13.h,
      color: black54,
      child: Row(
        children: [
          SizedBox(
            width: 2.w,
          ),
          Image(
            height: 11.h,
            image: const AssetImage(k3dLogo),
          ),
          Container(
            width: 0.1.w,
            height: 8.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            color: Colors.white,
          ),
          Text(
            "Tiatro IPTV",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<
                  Color>(appTextColorPrimary),
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10),
                  )
              ),
            ),
            child: Row(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          SizedBox(width: 2.w),
        ],
      ),
    );
  }
}