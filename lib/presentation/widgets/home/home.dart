part of '../widgets.dart';

class HeadHome extends StatelessWidget {
  final String title;
  const HeadHome({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 2.w,
        right: 2.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: 20.w,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.04.w,
                    color: yellowStar
                ),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

