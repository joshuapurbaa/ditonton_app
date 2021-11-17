part of 'tv_home_bloc.dart';

class TopRatedTvHomeBloc extends Bloc<FetchTvListHome, TvHomeState> {
  final GetTopRatedTVs getTopRatedTVs;
  TopRatedTvHomeBloc(this.getTopRatedTVs) : super(TvHomeEmpty()) {
    on<FetchTvListHome>((event, emit) async {
      emit(TvHomeLoading());

      final result = await getTopRatedTVs.execute();
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
