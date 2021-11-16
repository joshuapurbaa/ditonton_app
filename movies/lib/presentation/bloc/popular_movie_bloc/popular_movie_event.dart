part of 'popular_movie_bloc.dart';

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();
}

class FetchData extends PopularMovieEvent {
  @override
  List<Object> get props => [];
}
