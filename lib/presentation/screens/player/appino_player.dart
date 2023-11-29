part of '../screens.dart';

class AppinoPlayer extends StatefulWidget {
  const AppinoPlayer({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  State<AppinoPlayer> createState() => _AppinoPlayerState();
}

class _AppinoPlayerState extends State<AppinoPlayer> {

  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  bool isPlayed = true;
  bool progress = true;

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.link))
      ..initialize().then((value) => setState(() {
        videoPlayerController.play();
      }));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
      customVideoPlayerSettings: CustomVideoPlayerSettings(
        showSeekButtons: true,
        showFullscreenButton: false,
        durationAfterControlsFadeOut: Duration(seconds: 20),
        pauseButton: Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: ElevatedButton(
            focusNode: f2,
            style: ButtonStyle(
              elevation:
              MaterialStateProperty.all(0),
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  bgBlackSendStar
              ),
            ),
            onPressed: () {
              videoPlayerController.pause();
              setState(() {
                // videoPlayerController.play();
              });
            },
            child: Icon(
                FontAwesomeIcons.pause,
                color: yellowStar, size: 3.w
            ),
          ),
        ),
        playButton: Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
          },
          child: ElevatedButton(
            focusNode: f2,
            style: ButtonStyle(
              elevation:
              MaterialStateProperty.all(0),
              backgroundColor:
              MaterialStateProperty.all<Color>(
                  bgBlackSendStar
              ),
            ),
            onPressed: () {
              videoPlayerController.play();
              setState(() {
                // videoPlayerController.play();
              });
            },
            child: Icon(
                FontAwesomeIcons.play,
                color: yellowStar, size: 3.w
            ),
            ),
          ),
        ),
      );
    videoPlayerController.addListener(listener);
  }

  void listener() async {
    if (!mounted) return;

    if (progress) {
      if (videoPlayerController.value.isPlaying) {
        setState(() {
          progress = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            color: Colors.black,
            child: Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
              },
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    videoPlayerController.pause();
                    videoPlayerController.play();
                    _customVideoPlayerController.setFullscreen(true);
                  });
                  await Future.delayed(const Duration(seconds: 10)).then((value) {
                    _customVideoPlayerController.setFullscreen(false);
                  });
                },
                child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController
                ),
              ),
            ),
          ),
          if (progress)
            const Center(
                child: CircularProgressIndicator(
                  color: yellowStar,
                )),
        ],
      ),
    );
  }
}
