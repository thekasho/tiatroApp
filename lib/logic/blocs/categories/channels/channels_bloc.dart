import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiatrotv/helpers/helpers.dart';
import 'package:tiatrotv/repository/models/channel_movie.dart';
import 'package:tiatrotv/repository/api/api.dart';
import 'package:tiatrotv/repository/models/channelLive.dart';
import 'package:tiatrotv/repository/models/channel_serie.dart';

part 'channels_event.dart';
part 'channels_state.dart';

class ChannelsBloc extends Bloc<ChannelsEvent, ChannelsState> {
  final IpTvApi api;

  ChannelsBloc(this.api) : super(ChannelsWaiting()) {

    on<GetLiveChannelsEvent>((event, emit) async {
      emit(ChannelsLoading());

      if (event.typeCategory == TypeCategory.live) {
        emit(ChannelsLoading());

        final result = await api.getLiveChannels(event.catyId);
        emit(ChannelsLiveSuccess(result));

      } else if (event.typeCategory == TypeCategory.movies) {

        final result = await api.getMovieChannels(event.catyId);
        emit(ChannelsMovieSuccess(result));
      } else if (event.typeCategory == TypeCategory.series) {

        final result = await api.getSeriesChannels(event.catyId);
        emit(ChannelsSeriesSuccess(result));
      }
    });

  }
}
