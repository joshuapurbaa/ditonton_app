import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/domain/usecases/get_episode_tv_detail.dart';

part 'tv_episode_event.dart';
part 'tv_episode_state.dart';

class TvEpisodeBloc extends Bloc<TvEpisodeEvent, TvEpisodeState> {
  final GetEpisodeTvDetail _getEpisodeTvDetail;
  TvEpisodeBloc(this._getEpisodeTvDetail) : super(EpisodeEmpty()) {
    on<FetchEpisodeData>((event, emit) async {
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      final episodeNumber = event.episodeNumber;
      emit(EpisodeLoading());
      final result =
          await _getEpisodeTvDetail.execute(id, seasonNumber, episodeNumber);
      result.fold(
        (failure) => emit(
          EpisodeError(failure.message),
        ),
        (data) => emit(
          EpisodeHasData(data),
        ),
      );
    });
  }
}
