import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:tv_series/domain/entities/tv_episode.dart';
import 'package:tv_series/presentation/bloc/tv_episode_bloc/tv_episode_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TvEpisodePage extends StatefulWidget {
  static const TV_EPISODE_ROUTE = '/tv-episode';

  final int id;
  final int seasonNumber;
  final int episodeNumber;
  TvEpisodePage({
    required this.id,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  @override
  _TvEpisodePageState createState() => _TvEpisodePageState();
}

class _TvEpisodePageState extends State<TvEpisodePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvEpisodeBloc>().add(
            FetchEpisodeData(
              widget.id,
              widget.seasonNumber,
              widget.episodeNumber,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvEpisodeBloc, TvEpisodeState>(
        builder: (context, state) {
          if (state is EpisodeLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EpisodeHasData) {
            final tvEpisode = state.result;
            return SafeArea(
              child: EpisodeContent(tvEpisode),
            );
          } else if (state is EpisodeError) {
            return Text(
              state.message,
              key: Key('episodes_message_error'),
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

class EpisodeContent extends StatelessWidget {
  final TvEpisode tvEpisode;
  EpisodeContent(this.tvEpisode);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              tvEpisode.stillPath != null
                  ? CachedNetworkImage(
                      height: 300,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${tvEpisode.stillPath}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                      ),
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Image.network('$NO_IMAGE_URL')),
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
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'S${tvEpisode.seasonNumber}:E${tvEpisode.episodeNumber} "${tvEpisode.name}"',
                  style: kHeading5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  tvEpisode.overview.length < 1 ? '-' : tvEpisode.overview,
                  style: kBodyText,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Guest Stars',
                  style: kHeading6,
                ),
              ],
            ),
          ),
          if (tvEpisode.guestStars.length == 0)
            Center(child: Text('Sory, we don\'t have gueststar data')),
          if (tvEpisode.guestStars.length > 0)
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = tvEpisode.guestStars[index];
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 150,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          bottom: 2,
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 25, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: kSubtitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'as. ${item.character}',
                                    style: kBodyText.copyWith(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            height: 200,
                            imageUrl: item.profilePath != null
                                ? '$BASE_IMAGE_URL${item.profilePath}'
                                : '$NO_IMAGE_URL',
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: tvEpisode.guestStars.length,
              ),
            ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: Text(
              'Crew',
              style: kHeading6,
            ),
          ),
          if (tvEpisode.crew.length < 1)
            Center(child: Text('Sory, we don\'t have crew data')),
          if (tvEpisode.crew.length > 0)
            Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = tvEpisode.crew[index];
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 150,
                    color: Colors.black,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          bottom: 2,
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              color: kGrey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 25, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: kSubtitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'as. ${item.job}',
                                    style: kBodyText.copyWith(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            height: 200,
                            imageUrl: item.profilePath != null
                                ? '$BASE_IMAGE_URL${item.profilePath}'
                                : '$NO_IMAGE_URL',
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: tvEpisode.crew.length,
              ),
            ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
