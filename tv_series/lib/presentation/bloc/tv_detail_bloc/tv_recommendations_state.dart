part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsState extends Equatable {
  const TvRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvRecommendationEmpty extends TvRecommendationsState {}

class TvRecommendationLoading extends TvRecommendationsState {}

class TvRecommendationError extends TvRecommendationsState {
  final String message;

  TvRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecommendationHasData extends TvRecommendationsState {
  final List<Tv> recommendation;

  TvRecommendationHasData(this.recommendation);

  @override
  List<Object> get props => [recommendation];
}
