part of '../screens.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key, required this.controller, required this.customVideoPlayerController})
      : super(key: key);
  final VideoPlayerController? controller;
  final CustomVideoPlayerController? customVideoPlayerController;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlayed = true;
  bool showControllersVideo = false;
  
  @override
  void dispose() {
    widget.controller?.pause();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (widget.controller == null) {
      return Container(
        margin: EdgeInsets.only(top: 5.h),
        width: 60.w,
        height: 50.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: const Center(child: CircularProgressIndicator(color: appTextColorPrimary)),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          showControllersVideo = !showControllersVideo;
        });
      },
      onDoubleTap: () {
        if(context.read<VideoCubit>().state.isFull == true){
          context.read<VideoCubit>().changeUrlVideo(false);
          context.read<VideoCubit>().state.isFull == false;
          setState(() {});
        }
        else {
          context.read<VideoCubit>().changeUrlVideo(true);
          context.read<VideoCubit>().state.isFull == true;
          setState(() {});
        }
      },
      child: Container(
        width: 100.w,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [

            CustomVideoPlayer(
                customVideoPlayerController: widget.customVideoPlayerController!
            ),

            BlocBuilder<VideoCubit, VideoState>(
              builder: (context, state) {
                if (!state.isFull) {
                  return const SizedBox();
                }
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 6.w,
                        child: Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
                          },
                          child: ElevatedButton(
                            autofocus: true,
                            onPressed: () {
                              context.read<VideoCubit>().changeUrlVideo(false);
                              context.read<VideoCubit>().state.isFull == false;
                              setState(() {});
                            },
                            style: ButtonStyle(
                              elevation:
                              MaterialStateProperty.all(0),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.transparent
                              ),
                            ),
                            child: Icon(
                                Icons.arrow_back_ios,
                                color: yellowStar, size: 3.w
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
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
