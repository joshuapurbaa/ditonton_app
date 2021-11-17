part of 'tv_home_bloc.dart';

class AiringTodayTvHomeBloc extends Bloc<FetchTvListHome, TvHomeState> {
  final GetTvAiringToday getTvAiringToday;
  AiringTodayTvHomeBloc(this.getTvAiringToday) : super(TvHomeEmpty()) {
    on<FetchTvListHome>((event, emit) async {
      emit(TvHomeLoading());

      final result = await getTvAiringToday.execute();
      result.fold(
        (failure) => emit(
          TvHomeError(failure.message),
        ),
        (data) => emit(
          TvHomeHasData(tv: data),
        ),
      );
    });
  }
}
