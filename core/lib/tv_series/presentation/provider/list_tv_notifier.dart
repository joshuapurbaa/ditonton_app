import '../../../utils/state_enum.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecase/get_popular_tv.dart';
import '../../domain/usecase/get_top_rated_tv.dart';
import '../../domain/usecase/get_tv_airing_today.dart';
import 'package:flutter/foundation.dart';

class TVListNotifier extends ChangeNotifier {
  var _airingTodayTVs = <Tv>[];
  List<Tv> get airingTodayTVs => _airingTodayTVs;

  RequestState _airingTodayTVsState = RequestState.Empty;
  RequestState get airingTodayTVsState => _airingTodayTVsState;

  var _popularTVs = <Tv>[];
  List<Tv> get popularTVs => _popularTVs;

  RequestState _popularTVsState = RequestState.Empty;
  RequestState get popularTVsState => _popularTVsState;

  var _topRatedTVs = <Tv>[];
  List<Tv> get topRatedTVs => _topRatedTVs;

  RequestState _topRatedTVsState = RequestState.Empty;
  RequestState get topRatedTVsState => _topRatedTVsState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getTvAiringToday,
    required this.getPopularTVs,
    required this.getTopRatedTVs,
  });

  final GetTvAiringToday getTvAiringToday;
  final GetPopularTVs getPopularTVs;
  final GetTopRatedTVs getTopRatedTVs;

  Future<void> fetchAiringTodayTVs() async {
    _airingTodayTVsState = RequestState.Loading;
    notifyListeners();
    final result = await getTvAiringToday.execute();

    result.fold((failure) {
      _airingTodayTVsState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (values) {
      _airingTodayTVs = [...values];
      _airingTodayTVsState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTVs() async {
    _popularTVsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVs.execute();

    result.fold((failure) {
      _popularTVsState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (values) {
      _popularTVsState = RequestState.Loaded;
      _popularTVs = [...values];
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTVs() async {
    _topRatedTVsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVs.execute();

    result.fold((failure) {
      _topRatedTVsState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (values) {
      _topRatedTVsState = RequestState.Loaded;
      _topRatedTVs = [...values];
      notifyListeners();
    });
  }
}
