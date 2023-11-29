part of '../widgets.dart';

class AppBarMovies extends StatefulWidget {
  const AppBarMovies({Key? key, this.onSearch}) : super(key: key);
  final Function(String)? onSearch;

  @override
  State<AppBarMovies> createState() => _AppBarMoviesState();
}

class _AppBarMoviesState extends State<AppBarMovies> {
  bool showSearch = false;
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 9.h,
      decoration: BoxDecoration(
        color: bgBlackSendStar,
        border: Border(
          bottom: BorderSide(
            width: 0.13.w,
            // color: kColorPrimaryDark
          ),
        ),
      ),
      child: Row(
        children: [
          Image(
            height: 11.h,
            image: const AssetImage(k3dLogo),
          ),
          const Spacer(),
          SizedBox(
            width: 6.w,
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              },
              child: ElevatedButton(
                onPressed: () {
                  context.read<VideoCubit>().changeUrlVideo(false);
                  Get.back();
                },
                style: ButtonStyle(
                  elevation:
                  MaterialStateProperty.all(0),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      bgBlackSendStar.withOpacity(0)
                  ),
                ),
                child: Icon(
                    FontAwesomeIcons.chevronRight,
                    color: yellowStar, size: 3.w
                ),
              ),
            ),
          ),
          SizedBox(width: 1.w)
        ],
      ),
    );
  }
}