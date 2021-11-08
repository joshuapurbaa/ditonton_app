import 'package:ditonton/tv_series/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';

class TvSeriesAirDate extends StatelessWidget {
  const TvSeriesAirDate({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  final TvDetail tvSeries;

  @override
  Widget build(BuildContext context) {
    if (tvSeries.inProduction) {
      if (tvSeries.firstAirDate.toString().isNotEmpty) {
        var parseDate = tvSeries.firstAirDate;
        var date = '${parseDate?.day}-${parseDate?.month}-${parseDate?.year}';
        return Text('$date - Now');
      } else {
        return Text('Unknown Date Production');
      }
    } else {
      return Text(
          '${tvSeries.firstAirDate.toString()} - ${tvSeries.lastAirDate.toString()}');
    }
  }
}
