import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/tv_series.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTVs getPopularTVs;
  PopularTvBloc(this.getPopularTVs) : super(PopularTvEmpty()) {
    on<PopularTvEvent>((event, emit) async {
      emit(PopularTvLoading());

      final result = await getPopularTVs.execute();
      result.fold(
        (failure) => emit(
          PopularTvError(failure.message),
        ),
        (TvData) => emit(
          PopularTvHasData(TvData),
        ),
      );
    });
  }
}
