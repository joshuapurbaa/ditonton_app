import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_recommendations_event.dart';
part 'tv_recommendations_state.dart';

class TvRecommendationsBloc
    extends Bloc<TvRecommendationsEvent, TvRecommendationsState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecommendationsBloc(this.getTvRecommendations)
      : super(TvRecommendationEmpty()) {
    on<FetchTvRecommendations>((event, emit) async {
      emit(TvRecommendationLoading());

      final result = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) => emit(
          TvRecommendationError(failure.message),
        ),
        (data) => emit(
          TvRecommendationHasData(data),
        ),
      );
    });
  }
}
