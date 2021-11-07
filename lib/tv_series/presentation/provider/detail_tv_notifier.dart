import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:ditonton/tv_series/domain/entities/tv_detail.dart';
import 'package:ditonton/tv_series/domain/entities/tv_episode.dart';
import 'package:ditonton/tv_series/domain/usecase/get_detail_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/get_tv_recommendations.dart';
import 'package:ditonton/tv_series/domain/usecase/get_tv_season_eps.dart';
import 'package:ditonton/tv_series/domain/usecase/get_watchlist_tv_status.dart';
import 'package:ditonton/tv_series/domain/usecase/remove_watchlist_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/save_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class TvDetailNotifier extends ChangeNotifier {
  final GetDetailTVs getDetailTVs;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getTvWatchListStatus;
  final GetTvSeasonEpisodes getTvSeasonEpisodes;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getDetailTVs,
    required this.getTvRecommendations,
    required this.getTvWatchListStatus,
    required this.getTvSeasonEpisodes,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  List<Tv> _tvRecommendations = <Tv>[];
  List<Tv> get recommendation => _tvRecommendations;
  RequestState _tvRecommendationState = RequestState.Empty;
  RequestState get recommendationState => _tvRecommendationState;

  var _tvSeasonEpisode = <TvEpisode>[];
  List<TvEpisode> get tvSeasonEpisode => _tvSeasonEpisode;
  RequestState _tvSeasonEpisodeState = RequestState.Empty;
  RequestState get tvSeasonEpisodeState => _tvSeasonEpisodeState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getDetailTVs.execute(id);
    final tvRecommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold((failure) {
      _tvDetailState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvDetail) {
      _tvRecommendationState = RequestState.Loading;
      _tvDetail = tvDetail;
      notifyListeners();
      tvRecommendationResult.fold((failure) {
        _tvRecommendationState = RequestState.Error;
        _message = failure.message;
      }, (tvRecommendations) {
        _tvRecommendationState = RequestState.Loaded;
        _tvRecommendations = tvRecommendations;
      });
      _tvDetailState = RequestState.Loaded;
      notifyListeners();
      fetchTvSeasonEpisode(tvDetail.id, tvDetail.numberOfSeasons);
    });
  }

  Future<void> fetchTvSeasonEpisode(int id, int totalSeasonEps) async {
    _tvSeasonEpisodeState = RequestState.Loading;
    notifyListeners();
    final result = await getTvSeasonEpisodes.execute(id, totalSeasonEps);
    result.fold(
      (failure) {
        _tvSeasonEpisodeState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeasonEpisode) {
        _tvSeasonEpisodeState = RequestState.Loaded;
        _tvSeasonEpisode = tvSeasonEpisode;
        notifyListeners();
      },
    );
  }

  Future<void> addWatchlist(TvDetail tvSeries) async {
    final result = await saveWatchlistTv.execute(tvSeries);

    await result.fold(
      (failure) async {
        _tvDetailState = RequestState.Error;
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(
      tvSeries.id,
    );
  }

  Future<void> removeFromWatchlist(TvDetail tvSeries) async {
    final result = await removeWatchlistTv.execute(tvSeries);

    await result.fold(
      (failure) async {
        _tvDetailState = RequestState.Error;
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
