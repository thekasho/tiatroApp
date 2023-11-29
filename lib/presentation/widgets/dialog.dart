part of 'widgets.dart';

class DialogTrailerYoutube extends StatefulWidget {
  const DialogTrailerYoutube({Key? key, required this.trailer, this.thumb})
      : super(key: key);
  final String trailer;
  final String? thumb;

  @override
  State<DialogTrailerYoutube> createState() => _DialogTrailerYoutubeState();
}

class _DialogTrailerYoutubeState extends State<DialogTrailerYoutube> {
  late final PodPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://youtu.be/${widget.trailer}',
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
        isLooping: false,
      ),
    )..initialise();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Ink(
        decoration: kDecorBackground,
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PodVideoPlayer(
                controller: controller,
                onToggleFullScreen: (value) async {},
                alwaysShowProgressBar: false,
                podProgressBarConfig: const PodProgressBarConfig(
                  alwaysVisibleCircleHandler: false,
                  circleHandlerColor: kColorPrimary,
                  playingBarColor: kColorPrimary,
                ),
                videoThumbnail: widget.thumb == null
                    ? null
                    : DecorationImage(
                        image: NetworkImage(widget.thumb ?? ""),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardButtonWatchMovie(
                  isFocused: true,
                  title: "Exit",
                  onTap: () => Get.back(),
                ),
                const SizedBox(width: 15),
                CardButtonWatchMovie(
                  title: controller.isVideoPlaying ? "Pause" : "Play",
                  onTap: () {
                    setState(() {
                      if (controller.isVideoPlaying) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
