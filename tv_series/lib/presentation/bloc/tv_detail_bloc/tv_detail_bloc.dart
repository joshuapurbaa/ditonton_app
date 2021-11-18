import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/usecases/get_detail_tv.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetDetailTVs getDetailTVs;
  TvDetailBloc(this.getDetailTVs) : super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());

      final result = await getDetailTVs.execute(event.id);
      result.fold(
        (failure) => emit(
          TvDetailError(failure.message),
        ),
        (TvDatail) => emit(
          TvDetailHasData(TvDatail),
        ),
      );
    });
  }
}
