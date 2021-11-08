import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:ditonton/tv_series/domain/entities/tv_detail.dart';
import 'package:ditonton/tv_series/domain/entities/tv_episode.dart';
import 'package:ditonton/tv_series/domain/usecase/get_detail_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/get_tv_recommendations.dart';
import 'package:ditonton/tv_series/domain/usecase/get_watchlist_tv_status.dart';
import 'package:ditonton/tv_series/domain/usecase/remove_watchlist_tv.dart';
import 'package:ditonton/tv_series/domain/usecase/save_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailTVs getDetailTVs;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotifier({
    required this.getDetailTVs,
    required this.getTvRecommendations,
    required this.getTvWatchListStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendation => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  var _tvSeasonEps = <TvEpisode>[];
  List<TvEpisode> get tvSeasonEps => _tvSeasonEps;

  RequestState _tvSeasonEpsState = RequestState.Empty;
  RequestState get tvSeasonEpsState => _tvSeasonEpsState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getDetailTVs.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _recommendationState = RequestState.Loading;
        _tvDetail = tvSeries;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvSeries) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tvSeries;
          },
        );
        _tvDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

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
