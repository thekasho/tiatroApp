import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/api/api.dart';
import '../../../../repository/models/category.dart';

part 'series_caty_event.dart';
part 'series_caty_state.dart';

class SeriesCatyBloc extends Bloc<SeriesCatyEvent, SeriesCatyState> {
  final IpTvApi api;
  SeriesCatyBloc(this.api) : super(SeriesCatyInitial()) {
    on<GetSeriesCategories>((event, emit) async {
      emit(SeriesCatyLoading());
      final result = await api.getCategories("get_series_categories");
      emit(SeriesCatySuccess(result));
    });
  }
}
