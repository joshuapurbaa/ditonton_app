part of 'tv_recommendations_bloc.dart';

abstract class TvRecommendationsEvent extends Equatable {
  const TvRecommendationsEvent();
}

class FetchTvRecommendations extends TvRecommendationsEvent {
  final int id;

  FetchTvRecommendations(this.id);
  @override
  List<Object> get props => [id];
}
