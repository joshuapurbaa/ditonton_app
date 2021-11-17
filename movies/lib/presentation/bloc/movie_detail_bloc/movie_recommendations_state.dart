part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MovieRecommendationsState {}

class MovieRecommendationLoading extends MovieRecommendationsState {}

class MovieRecommendationError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends MovieRecommendationsState {
  final List<Movie> recommendation;

  MovieRecommendationHasData(this.recommendation);

  @override
  List<Object> get props => [recommendation];
}
