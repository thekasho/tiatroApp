part of '../widgets.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {Key? key,
        required this.title,
        required this.onTap,
        this.isSelected = false,
        this.link,
        this.image,
        this.count,
      })
      : super(key: key);
  final String title;
  final Function() onTap;
  final bool isSelected;
  final String? link;
  final String? image;
  final String? count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
              left: 0.5.w,
              right: 0.5.w
            )),
            elevation:
            MaterialStateProperty.all(0),
            backgroundColor:
            MaterialStateProperty.all<Color>(
                isSelected ? black12 : bg2
            ),
          ),
          child: SizedBox(
            child: Row(
              children: [
                Text("$count"),
                SizedBox(width: 1.w),
                image != null
                  ? CachedNetworkImage(
                    maxWidthDiskCache: 40,
                    imageUrl: image ?? "",
                    errorWidget: (_, i, e) {
                      return Icon(
                        FontAwesomeIcons.tv,
                        size: 13.sp,
                        color: Colors.white,
                      );
                    },
                  )
                  : isSelected ? Icon(
                  FontAwesomeIcons.play,
                  color: yellowStar,
                  size: 13.sp,
                ) :
                Image.asset("assets/images/3d.png", width: 3.w),
                SizedBox(width: 1.w),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo"
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 0.1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: offlineGray.withOpacity(0.6),
                    ),
                    child: count == 0 ?
                    Container(
                      width: 3.w,
                      height: 5.h,
                      child: CircularProgressIndicator(
                        color: appTextColorPrimary,
                        strokeWidth: 2,
                      ),
                    ) :
                    Text(
                      count.toString(),
                      style: TextStyle(
                          color: yellowStar,
                          fontSize: 12.sp,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}