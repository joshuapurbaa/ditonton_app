import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

// movie
class MockMovieSearchBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

class MovieSearchStateFake extends Fake implements SearchMovieState {}

class MovieSearchEventFake extends Fake implements SearchMovieEvent {}

// tv
class MockTvSearchBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}

class TvSearchStateFake extends Fake implements SearchTvState {}

class TvSearchEventFake extends Fake implements SearchTvEvent {}
