part of 'series_caty_bloc.dart';

@immutable
abstract class SeriesCatyState {}

class SeriesCatyInitial extends SeriesCatyState {}

class SeriesCatyLoading extends SeriesCatyState {}

class SeriesCatySuccess extends SeriesCatyState {
  final List<CategoryModel> categories;

  SeriesCatySuccess(this.categories);
}
