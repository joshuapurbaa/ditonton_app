import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/domain/entities/tv_season.dart';
import 'package:tv_series/presentation/bloc/tv_season_bloc/tv_season_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';

class TvSeasonPage extends StatefulWidget {
  static const TV_SEASONS_ROUTE = '/tv-season';

  final int id;
  final int seasonNumber;
  TvSeasonPage({required this.id, required this.seasonNumber});

  @override
  _TvSeasonPageState createState() => _TvSeasonPageState();
}

class _TvSeasonPageState extends State<TvSeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeasonBloc>().add(
            FetchSeasonData(
              widget.id,
              widget.seasonNumber,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeasonBloc, TvSeasonState>(
        builder: (context, state) {
          if (state is SeasonLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonHasData) {
            final tvSeason = state.result;
            return SafeArea(
              child: SeasonContent(tvSeason, widget.id, widget.seasonNumber),
            );
          } else if (state is SeasonError) {
            return Text(
              state.message,
              key: Key('season_message'),
            );
          } else {
            return Center(
              key: Key('error_image'),
              child: Text('Empty'),
            );
          }
        },
      ),
    );
  }
}

class SeasonContent extends StatelessWidget {
  final TvSeason tvSeason;
  final int id;
  final int seasonNumber;

  SeasonContent(
    this.tvSeason,
    this.id,
    this.seasonNumber,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: tvSeason.posterPath != null
              ? 'https://image.tmdb.org/t/p/w500${tvSeason.posterPath}'
              : '$NO_IMAGE_URL',
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tvSeason.name,
                                  style: kHeading5,
                                ),
                                Text(
                                  'Total Episode: ${tvSeason.episodes.length.toString()}',
                                  style: kSubtitle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              tvSeason.overview.length < 1
                                  ? '-'
                                  : tvSeason.overview,
                              style: kBodyText,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final item = tvSeason.episodes[index];
                                  return _tvEpisode(context, item);
                                },
                                itemCount: tvSeason.episodes.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
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
              key: Key('button_back'),
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

  Widget _tvEpisode(BuildContext ctx, TvEpisode tvEpisode) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            ctx,
            TV_EPISODE_ROUTE,
            arguments: {
              'id': id,
              'episodeNumber': tvEpisode.episodeNumber,
              'seasonNumber': seasonNumber,
            },
          );
        },
        child: Stack(
          children: [
            Container(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      height: 80,
                      width: 160,
                      fit: tvEpisode.stillPath != null
                          ? BoxFit.cover
                          : BoxFit.scaleDown,
                      imageUrl: tvEpisode.stillPath != null
                          ? '$BASE_IMAGE_URL${tvEpisode.stillPath}'
                          : '$NO_IMAGE_URL',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'S${tvEpisode.seasonNumber}:E${tvEpisode.episodeNumber} "${tvEpisode.name}"',
                    style: kBodyText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    tvEpisode.overview,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: kBodyText.copyWith(fontSize: 10),
                  )
                ],
              ),
            ),
            Container(
              width: 160,
              padding: EdgeInsets.only(top: 20),
              child: Icon(
                Icons.play_circle,
                size: 40,
                color: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
