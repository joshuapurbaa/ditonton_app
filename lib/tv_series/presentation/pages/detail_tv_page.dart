import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/tv_series/domain/entities/tv.dart';
import 'package:ditonton/tv_series/domain/entities/tv_detail.dart';
import 'package:ditonton/tv_series/presentation/provider/detail_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DetailTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  DetailTvPage({required this.id});

  @override
  _DetailTvPageState createState() => _DetailTvPageState();
}

class _DetailTvPageState extends State<DetailTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(context, listen: false)
        ..fetchTvDetail(widget.id)
        ..loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvDetailState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvDetailState == RequestState.Loaded) {
            final tvDetail = provider.tvDetail;
            return SafeArea(
              child: DetailContent(
                tvDetail,
                provider.tvRecommendation,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;
  DetailContent(
    this.tvDetail,
    this.recommendations,
    this.isAddedWatchlist,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .addWatchlist(tvDetail);
                                } else {
                                  await Provider.of<TvDetailNotifier>(context,
                                          listen: false)
                                      .removeFromWatchlist(tvDetail);
                                }

                                final message = Provider.of<TvDetailNotifier>(
                                        context,
                                        listen: false)
                                    .watchlistMessage;

                                if (message ==
                                        TvDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvDetail.genres),
                            ),
                            Text(
                              tvDetail.episodeRunTime.isEmpty
                                  ? ''
                                  : '${_showDuration(tvDetail.episodeRunTime.first)}/episode',
                            ),
                            TvSeriesAirDate(tvSeries: tvDetail),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            // if (tvDetail.seasons.isNotEmpty) ...[
                            //   SizedBox(height: 16),
                            //   Text(
                            //     'Season',
                            //     style: kHeading6,
                            //   ),
                            //   SizedBox(
                            //     height: 200,
                            //     child: ListView.builder(
                            //       shrinkWrap: true,
                            //       scrollDirection: Axis.horizontal,
                            //       itemCount: tvDetail.seasons.length,
                            //       itemExtent: 120,
                            //       itemBuilder: (context, index) {
                            //         final season = tvDetail.seasons[index];
                            //         return Padding(
                            //           padding: const EdgeInsets.all(4.0),
                            //           child: InkWell(
                            //             onTap: () {
                            //               // Navigator.of(context).pushNamed(
                            //               //   TVEpisodeSeasonPage.ROUTE_NAME,
                            //               //   arguments: {
                            //               //     'tv': tv,
                            //               //     'season': season
                            //               //   },
                            //               // );
                            //             },
                            //             child: ClipRRect(
                            //               borderRadius:
                            //                   BorderRadius.circular(8.0),
                            //               child: CachedNetworkImage(
                            //                 fit: BoxFit.cover,
                            //                 imageUrl:
                            //                     'https://image.tmdb.org/t/p/w500${season.posterPath}',
                            //                 placeholder: (context, url) =>
                            //                     Center(
                            //                   child:
                            //                       CircularProgressIndicator(),
                            //                 ),
                            //                 errorWidget: (context, url, error) {
                            //                   return Container(
                            //                     height: double.infinity,
                            //                     color: kMikadoYellow,
                            //                     child: Center(
                            //                       child: FittedBox(
                            //                         child: Transform.rotate(
                            //                           angle: 45,
                            //                           child: Text(
                            //                             '${season.name}',
                            //                             style: TextStyle(
                            //                               fontSize: 16.0,
                            //                               fontWeight:
                            //                                   FontWeight.bold,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   );
                            //                 },
                            //               ),
                            //             ),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ),
                            // ],
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                DetailTvPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

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
        return Text('${tvSeries.firstAirDate.toString()} - Now');
      } else {
        return Text('Unknown Date Production');
      }
    } else {
      return Text(
          '${tvSeries.firstAirDate.toString()} - ${tvSeries.lastAirDate.toString()}');
    }
  }
}
