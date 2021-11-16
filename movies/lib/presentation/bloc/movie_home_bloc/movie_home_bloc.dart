import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';

part 'now_playing_movie_home_bloc.dart';
part 'popular_movie_home_bloc.dart';
part 'top_rated_movie_home_bloc.dart';
part 'movie_home_event.dart';
part 'movie_home_state.dart';
