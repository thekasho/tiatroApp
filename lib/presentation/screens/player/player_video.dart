part of '../screens.dart';

class StreamPlayerPage extends StatefulWidget {
  const StreamPlayerPage({Key? key, required this.controller})
      : super(key: key);
  final VlcPlayerController? controller;

  @override
  State<StreamPlayerPage> createState() => _StreamPlayerPageState();
}

class _StreamPlayerPageState extends State<StreamPlayerPage> {
  // VlcPlayerController? _videoPlayerController;
  bool isPlayed = true;
  String position = '';
  String duration = '';
  double sliderValue = 0.0;
  bool validPosition = false;
  bool showControllersVideo = true;

  @override
  void initState() {
    // debugPrint("RUN URL ${widget.link}");
    // _videoPlayerController = widget.controller;

    super.initState();

    if(widget.controller !=null){
      // widget.controller!.addListener(listener);
    }
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
        height: 100.w,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [

            VlcPlayer(
              controller: widget.controller!,
              aspectRatio: 16 / 9,
              placeholder: const Center(child: CircularProgressIndicator(color: appTextColorPrimary)),
            ),

            BlocBuilder<VideoCubit, VideoState>(
              builder: (context, state) {
                if (!state.isFull) {
                  return const SizedBox();
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: !showControllersVideo
                  ? const SizedBox()
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 6.w,
                        child: Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.control): const ActivateIntent(),
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (isPlayed) {
                                  widget.controller!.pause();
                                  isPlayed = false;
                                } else {
                                  widget.controller!.play();
                                  isPlayed = true;
                                }
                              });
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
                              isPlayed
                              ? FontAwesomeIcons.pause
                              : FontAwesomeIcons.play,
                              color: yellowStar, size: 4.w
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
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
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
