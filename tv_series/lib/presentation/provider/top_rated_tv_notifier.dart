import 'package:core/core.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';

import 'package:flutter/foundation.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTVs getTopRatedTVs;

  TopRatedTvNotifier({required this.getTopRatedTVs});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvTopRated = [];
  List<Tv> get tvTopRated => _tvTopRated;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTVs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVs.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvTopRatedData) {
        _tvTopRated = tvTopRatedData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
