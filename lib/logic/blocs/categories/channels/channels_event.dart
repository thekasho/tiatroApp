part of 'channels_bloc.dart';

@immutable
abstract class ChannelsEvent {}

class WaitLiveChannelsEvent extends ChannelsEvent {

}

class GetLiveChannelsEvent extends ChannelsEvent {
  final String catyId;
  final TypeCategory typeCategory;

  GetLiveChannelsEvent({required this.typeCategory, required this.catyId});
}
