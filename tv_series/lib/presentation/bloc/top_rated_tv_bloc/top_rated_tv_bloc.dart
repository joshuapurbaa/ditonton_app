import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTVs getTopRatedTVs;
  TopRatedTvBloc(this.getTopRatedTVs) : super(TopRatedTvEmpty()) {
    on<TopRatedTvEvent>((event, emit) async {
      emit(TopRatedTvLoading());

      final result = await getTopRatedTVs.execute();
      result.fold(
        (failure) => emit(
          TopRatedTvError(failure.message),
        ),
        (TvData) => emit(
          TopRatedTvHasData(TvData),
        ),
      );
    });
  }
}
