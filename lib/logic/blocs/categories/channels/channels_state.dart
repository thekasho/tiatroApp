part of 'channels_bloc.dart';

@immutable
abstract class ChannelsState {}

class ChannelsWaiting extends ChannelsState {}

class ChannelsLoading extends ChannelsState {}

class ChannelsLiveSuccess extends ChannelsState {
  final List<ChannelLive> channels;
  ChannelsLiveSuccess(this.channels);
}

class ChannelsMovieSuccess extends ChannelsState {
  final List<ChannelMovie> channels;
  ChannelsMovieSuccess(this.channels);
}

class ChannelsSeriesSuccess extends ChannelsState {
  final List<ChannelSerie> channels;
  ChannelsSeriesSuccess(this.channels);
}
