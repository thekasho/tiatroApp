part of 'live_caty_bloc.dart';

@immutable
abstract class LiveCatyState {}

class LiveCatyInitial extends LiveCatyState {}

class LiveCatyLoading extends LiveCatyState {}

class LiveCatySuccess extends LiveCatyState {
  final List<CategoryModel> categories;

  LiveCatySuccess(this.categories);
}
