part of 'tv_home_bloc.dart';

abstract class TvHomeState extends Equatable {
  const TvHomeState();

  @override
  List<Object> get props => [];
}

class TvHomeEmpty extends TvHomeState {}

class TvHomeLoading extends TvHomeState {}

class TvHomeError extends TvHomeState {
  final String message;

  TvHomeError(this.message);
  @override
  List<Object> get props => [message];
}

class TvHomeHasData extends TvHomeState {
  final List<Tv> tv;
  TvHomeHasData({
    required this.tv,
  });
  @override
  List<Object> get props => [tv];
}
