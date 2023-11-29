part of '../widgets.dart';

class AccountAppBar extends StatelessWidget {
  
  final String username;

  const AccountAppBar({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: blackSendStar,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: 10.h,
              color: bgBlackSendStar,
              child: Row(
                children: [
                  SizedBox(
                    width: 6.w,
                    child: Shortcuts(
                      shortcuts: <LogicalKeySet, Intent>{
                        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ButtonStyle(
                          elevation:
                          MaterialStateProperty.all(0),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              bgBlackSendStar
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: yellowStar, size: 3.w
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.1.w,
                    height: 8.h,
                    margin: EdgeInsets.only(
                        left: 1.w,
                        right: 3.w
                    ),
                    color: yellowStar,
                  ),
                  Image(
                    height: 9.h,
                    image: const AssetImage(k3dLogo),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(appTextColorPrimary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          username,
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
            ),
          ],
        ),
      ),
    );
  }
}
