// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/tv_series/domain/entities/tv.dart';
// import 'package:ditonton/tv_series/domain/usecase/get_tv_recommendations.dart';
// import 'package:flutter/foundation.dart';

// class TvRecommendationNotifier extends ChangeNotifier {
//   final GetTvRecommendations getTvRecommendations;
//   TvRecommendationNotifier({required this.getTvRecommendations});

//   List<Tv> _recomTVs = const [];
//   List<Tv> get recomTVs => _recomTVs;

//   RequestState _recomTvState = RequestState.Empty;
//   RequestState get recomTvState => _recomTvState;

//   String _message = '';
//   String get message => _message;

//   Future<void> fetchTVRecommendations(int id) async {
//     _recomTvState = RequestState.Loading;
//     notifyListeners();

//     final result = await getTvRecommendations.execute(id);
//     result.fold((failure) {
//       _recomTvState = RequestState.Error;
//       _message = failure.message;
//       notifyListeners();
//     }, (values) {
//       _recomTvState = RequestState.Loaded;
//       _recomTVs = [...values];
//       notifyListeners();
//     });
//   }
// }
