part of 'movie_home_bloc.dart';

abstract class MovieHomeEvent extends Equatable {
  const MovieHomeEvent();
}

class FetchMovieListHome extends MovieHomeEvent {
  @override
  List<Object> get props => [];
}
