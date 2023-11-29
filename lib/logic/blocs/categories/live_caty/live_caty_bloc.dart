import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/api/api.dart';
import '../../../../repository/models/category.dart';

part 'live_caty_event.dart';
part 'live_caty_state.dart';

class LiveCatyBloc extends Bloc<LiveCatyEvent, LiveCatyState> {
  final IpTvApi api;

  LiveCatyBloc(this.api) : super(LiveCatyInitial()) {
    on<GetLiveCategories>((event, emit) async {
      emit(LiveCatyLoading());
      final result = await api.getCategories("get_live_categories");
      emit(LiveCatySuccess(result));
    });
  }
}
