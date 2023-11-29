import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/api/api.dart';
import '../../../../repository/models/category.dart';

part 'movie_caty_event.dart';
part 'movie_caty_state.dart';

class MovieCatyBloc extends Bloc<MovieCatyEvent, MovieCatyState> {
  final IpTvApi api;

  MovieCatyBloc(this.api) : super(MovieCatyInitial()) {
    on<GetMovieCategories>((event, emit) async {
      emit(MovieCatyLoading());
      final result = await api.getCategories("get_vod_categories");
      emit(MovieCatySuccess(result));
    });
  }
}
