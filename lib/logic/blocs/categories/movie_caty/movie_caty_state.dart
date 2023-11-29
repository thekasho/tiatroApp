part of 'movie_caty_bloc.dart';

@immutable
abstract class MovieCatyState {}

class MovieCatyInitial extends MovieCatyState {}

class MovieCatyLoading extends MovieCatyState {}

class MovieCatySuccess extends MovieCatyState {
  final List<CategoryModel> categories;

  MovieCatySuccess(this.categories);
}
