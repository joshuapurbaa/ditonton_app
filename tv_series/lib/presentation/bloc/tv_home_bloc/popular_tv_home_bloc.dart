part of 'tv_home_bloc.dart';

class PopularTvHomeBloc extends Bloc<FetchTvListHome, TvHomeState> {
  final GetPopularTVs getPopularTVs;
  PopularTvHomeBloc(this.getPopularTVs) : super(TvHomeEmpty()) {
    on<FetchTvListHome>((event, emit) async {
      emit(TvHomeLoading());

      final result = await getPopularTVs.execute();
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
