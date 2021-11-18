import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_watchlist_bloc.dart';

// Detail
class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

// Watchlist
class MockTvWatchlistDetailBloc
    extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvDetailWatchlistBloc {}

class TvWatchlistDetailStateFake extends Fake implements TvWatchlistState {}

class TvWatchlistDetailEventFake extends Fake implements TvWatchlistEvent {}

// Recommendations
class MockTvRecommendationsBloc
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class TvRecommendationsStateFake extends Fake
    implements TvRecommendationsState {}

class TvRecommendationsEventFake extends Fake
    implements TvRecommendationsEvent {}

// Popular
class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class PopularTvStateFake extends Fake implements PopularTvState {}

class PopularTvEventFake extends Fake implements PopularTvEvent {}

// Top Rated
class MockTopRatedTvBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

class TopRatedTvStateFake extends Fake implements TopRatedTvState {}

class TopRatedTvEventFake extends Fake implements TopRatedTvEvent {}
