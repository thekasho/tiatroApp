import 'package:flutter_bloc/flutter_bloc.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoState(isFull: false));

  void changeUrlVideo(bool value) => emit(VideoState(isFull: value));
}
