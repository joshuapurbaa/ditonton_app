import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/presentation/bloc/tv_episode_bloc/tv_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';

// season
class MockTvSeasonBloc extends MockBloc<TvSeasonEvent, TvSeasonState>
    implements TvSeasonBloc {}

class TvSeasonStateFake extends Fake implements TvSeasonState {}

class TvSeasonEventFake extends Fake implements TvSeasonEvent {}

// episode
class MockTvEpisodeBloc extends MockBloc<TvEpisodeEvent, TvEpisodeState>
    implements TvEpisodeBloc {}

class TvEpisodeStateFake extends Fake implements TvEpisodeState {}

class TvEpisodeEventFake extends Fake implements TvEpisodeEvent {}
