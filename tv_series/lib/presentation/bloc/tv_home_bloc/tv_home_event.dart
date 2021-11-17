part of 'tv_home_bloc.dart';

abstract class TvHomeEvent extends Equatable {
  const TvHomeEvent();
}

class FetchTvListHome extends TvHomeEvent {
  @override
  List<Object> get props => [];
}
