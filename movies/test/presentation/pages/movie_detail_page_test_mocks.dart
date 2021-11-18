import 'package:bloc_test/bloc_test.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail_bloc/movie_watchlist_detail_bloc.dart';

// Detail
class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

// Watchlist
class MockMovieWatchlistDetailBloc
    extends MockBloc<MovieWatchlistDetailEvent, MovieWatchlistDetailState>
    implements MovieWatchlistDetailBloc {}

class MovieWatchlistDetailStateFake extends Fake
    implements MovieWatchlistDetailState {}

class MovieWatchlistDetailEventFake extends Fake
    implements MovieWatchlistDetailEvent {}

// Recommendations
class MockMovieRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class MovieRecommendationsStateFake extends Fake
    implements MovieRecommendationsState {}

class MovieRecommendationsEventFake extends Fake
    implements MovieRecommendationsEvent {}
