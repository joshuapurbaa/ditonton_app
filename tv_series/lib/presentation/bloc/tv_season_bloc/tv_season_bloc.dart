import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_season.dart';
import 'package:tv_series/domain/usecases/get_season_tv_detail.dart';

part 'tv_season_event.dart';
part 'tv_season_state.dart';

class TvSeasonBloc extends Bloc<TvSeasonEvent, TvSeasonState> {
  final GetTvSeasonDetail _getTvSeasonDetail;
  TvSeasonBloc(this._getTvSeasonDetail) : super(SeasonEmpty()) {
    on<FetchSeasonData>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      emit(SeasonLoading());
      final result = await _getTvSeasonDetail.execute(id, seasonNumber);
      result.fold(
        (failure) => emit(
          SeasonError(failure.message),
        ),
        (data) => emit(
          SeasonHasData(data),
        ),
      );
    });
  }
}
