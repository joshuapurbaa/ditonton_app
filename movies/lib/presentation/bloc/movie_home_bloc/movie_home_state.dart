part of 'movie_home_bloc.dart';

abstract class MovieHomeState extends Equatable {
  const MovieHomeState();

  @override
  List<Object> get props => [];
}

class MovieHomeEmpty extends MovieHomeState {}

class MovieHomeLoading extends MovieHomeState {}

class MovieHomeError extends MovieHomeState {
  final String message;

  MovieHomeError(this.message);
  @override
  List<Object> get props => [message];
}

class MovieHomeHasData extends MovieHomeState {
  final List<Movie> movie;
  MovieHomeHasData({
    required this.movie,
  });
  @override
  List<Object> get props => [movie];
}
