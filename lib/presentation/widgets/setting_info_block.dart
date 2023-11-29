import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../app_link.dart';
import '../../helpers/helpers.dart';

class SettingInfoBlock extends StatelessWidget {
  final int rowCount;
  final List identifierContent;

  const SettingInfoBlock(
      {super.key, required this.rowCount, required this.identifierContent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 45.w,
        decoration: BoxDecoration(
          color: kColorPrimaryDark.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 3.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rowCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: rowCount > 2 ? 7 : 6),
              itemBuilder: (BuildContext context, index) {
                return Row(
                  children: [
                    identifierContent[index]["icon"],
                    SizedBox(width: 1.w),
                    Text(
                      identifierContent[index]["title"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  final void Function() onTap;
  final String buttonTitle;
  final IconData buttonIcon;

  const SettingButtons({
    super.key, required this.onTap, required this.buttonTitle, required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 30.w,
          height: 9.h,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    kColorPrimary.withOpacity(.4),
                    kColorPrimaryDark.withOpacity(.4)
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      buttonTitle,
                      style: TextStyle(fontSize: 17.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Icon(buttonIcon, size: 19.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class SettingBottomCreator extends StatelessWidget {
  const SettingBottomCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'CreatedBy:',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
          ),
        ),
        InkWell(
          onTap: () async {
            await launchUrlString(
              kCreatorLink,
              mode: LaunchMode.externalApplication,
            );
          },
          child: Text(
            " $kCreatorName",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}