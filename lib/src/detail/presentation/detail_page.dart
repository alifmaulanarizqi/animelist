import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';
import 'package:fms/common_ui/widgets/appbar/common_appbar.dart';
import 'package:fms/src/animelist/presentation/add_anime/add_anime_page.dart';
import 'package:fms/src/animelist/presentation/add_anime/arg/animelist_arg.dart';
import 'package:fms/src/detail/presentation/arg/detail_arg.dart';
import 'package:fms/src/detail/presentation/widget/VideoTrailerPlayer.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_ui/utils/colors/common_colors.dart';
import '../../../common_ui/widgets/common_state/common_error_state.dart';
import '../../../core/utils/value_extension.dart';
import 'bloc/detail_bloc.dart';

class DetailPage extends StatefulWidget {
  static const route = '/detail';

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DetailBloc _bloc;

  int _animeId = 0;

  @override
  void initState() {
    super.initState();

    _bloc = DetailBloc(detailUseCase: GetIt.instance());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args = cast<DetailArg>(
      ModalRoute.of(context)?.settings.arguments,
    );
    var animeId = args?.id ?? 0;
    _animeId = animeId;

    _bloc.add(DetailInitEvent(id: _animeId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbar(
        textTitle: "Detail Anime",
        textColor: Colors.white,
        backgroundColor: CommonColors.blueB5,
      ),
      body: SafeArea(
        child: BlocConsumer<DetailBloc, DetailState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if(state is DetailFailedState) {
              return Column(
                children: [
                  _buildFailedDetail(state: state),
                  ElevatedButton(
                    onPressed: () {
                      _bloc.add(DetailInitEvent(
                        id: _animeId,
                      ));
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              );
            } else if (state is DetailLoadingState) {
              return _buildShimmerLoading();
            }

            return _buildDetailAnime(state: state);
          },
        ),
      ),
      floatingActionButton: BlocBuilder<DetailBloc, DetailState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is DetailSuccessState) {
            return FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddAnimePage.route,
                    arguments: AnimelistArg(
                        detailDto: state.data.detailDto
                    ),
                  );
                },
                backgroundColor: CommonColors.blue9F,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.playlist_add_rounded,
                  size: 30,
                  color: CommonColors.white,
                ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailAnime({
    required DetailState state,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 320,
                  child: Image.network(
                    state.data.detailDto.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
      
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Score',
                      style: CommonTypography.heading6.copyWith(
                        fontWeight: FontWeight.w400,
                        color: CommonColors.black21,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          size: 25,
                          color: CommonColors.black21,
                        ),
                        Text(
                            '${state.data.detailDto.score}',
                            style: CommonTypography.heading5.copyWith(
                              color: CommonColors.black21,
                              fontWeight: FontWeight.w500
                            )
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildCommonText(
                      label: 'Rank',
                      value: '#${state.data.detailDto.rank}',
                      valueColor: Colors.blueAccent,
                      crossAxisAlignment: CrossAxisAlignment.end
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildCommonText(
                      label: 'Popularity',
                      value: '#${state.data.detailDto.popularity}',
                      valueColor: Colors.blueAccent,
                      crossAxisAlignment: CrossAxisAlignment.end
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildCommonText(
                      label: 'Members',
                      value: NumberFormat("#,###").format(state.data.detailDto.members),
                      crossAxisAlignment: CrossAxisAlignment.end
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildCommonText(
                      label: 'Favorites',
                      value: NumberFormat("#,###").format(state.data.detailDto.favorites),
                      crossAxisAlignment: CrossAxisAlignment.end
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              state.data.detailDto.title,
              textAlign: TextAlign.center,
              style: CommonTypography.roboto20.copyWith(
                fontSize: 22,
                color: CommonColors.black21,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          _buildTypeAiringEpInfo(
            typeYear: '${state.data.detailDto.type}, ${state.data.detailDto.year}',
            isAiring: state.data.detailDto.isAiring,
            epDuration: '${state.data.detailDto.episode}, ${state.data.detailDto.duration}'
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildGenreAnime(genres: state.data.detailDto.genres)
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ExpandableText(
              state.data.detailDto.synopsis,
              textAlign: TextAlign.justify,
              style: CommonTypography.roboto16.copyWith(
                color: CommonColors.black21,
              ),
              expandText: 'show more',
              collapseText: 'show less',
              maxLines: 4,
              linkColor: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: VideoTrailerPlayer(youtubeId: state.data.detailDto.youtubeId),
          ),
          const SizedBox(
            height: 12,
          ),
          _buildSourceSeasonEtc(
            source: state.data.detailDto.source,
            seasonYear: '${state.data.detailDto.season} ${state.data.detailDto.year}',
            studios: state.data.detailDto.studios,
            aired: '${state.data.detailDto.airedFrom} to ${state.data.detailDto.airedTo}',
            rating: state.data.detailDto.rating,
            licensors: state.data.detailDto.licensors
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: _buildRelations(relations: state.data.detailDto.relations),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: _buildThemes(
              openings: state.data.detailDto.openings,
              endings: state.data.detailDto.endings,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeAiringEpInfo({
    required String typeYear,
    required bool isAiring,
    required String epDuration
  }) {
    return Container(
      color: CommonColors.greyF2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              typeYear,
              style: CommonTypography.roboto16.copyWith(
                  color: CommonColors.black21
              ),
            ),
            Text(
              isAiring ? 'Airing' : 'Finished',
              style: CommonTypography.roboto16.copyWith(
                  color: CommonColors.black21
              ),
            ),
            Text(
              epDuration,
              style: CommonTypography.roboto16.copyWith(
                  color: CommonColors.black21
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Widget> _buildGenreAnime({
    required List<String> genres  
  }) {
    List<Widget> listWidget = [];
    
    for (int i = 0; i < genres.length; i++) {
      var textValue = genres[i];
      if(i != genres.length-1) {
        textValue += '  *  ';
      }
      
      var textWidget = Text(
        textValue,
        style: CommonTypography.roboto16.copyWith(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500
        ),
      );

      listWidget.add(textWidget);
    }
    
    return listWidget;
  }

  Widget _buildSourceSeasonEtc({
    required String source,
    required String seasonYear,
    required List<String> studios,
    required String aired,
    required String rating,
    required List<String> licensors,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildCommonText(
                  label: 'Source',
                  value: source,
                ),
              ),
              Expanded(
                child: _buildCommonText(
                  label: 'Season',
                  value: source,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Studio',
                      style: CommonTypography.roboto16.copyWith(
                        color: CommonColors.black21,
                      ),
                    ),
                    Text(
                      studios.join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CommonTypography.roboto16.copyWith(
                          color: CommonColors.black21,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildCommonText(
                  label: 'Aired',
                  value: aired,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: _buildCommonText(
                  label: 'Rating',
                  value: rating,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Licensors',
                      style: CommonTypography.roboto16.copyWith(
                        color: CommonColors.black21,
                      ),
                    ),
                    Text(
                      licensors.isEmpty ? 'Unknown' : licensors.join(', '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CommonTypography.roboto16.copyWith(
                          color: CommonColors.black21,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRelations({
    required List<dynamic> relations
  }) {
    List<Widget> relationsWidget = [];
    for (var element in relations) {
      var rowContainer = Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              element['relation'],
              style: CommonTypography.roboto16.copyWith(
                color: CommonColors.black21
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${element["entry"][0]["name"]}',
              style: CommonTypography.roboto16.copyWith(
                  color: Colors.blueAccent,
                fontWeight: FontWeight.w500
              ),
            ),
          )
        ],
      );

      relationsWidget.add(rowContainer);
    }

    return relationsWidget;
  }

  Widget _buildThemes({
    required List<String> openings,
    required List<String> endings,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opening Theme',
          style: CommonTypography.roboto16.copyWith(
            color: CommonColors.black21
          ),
        ),
        ..._buildListTheme(themes: openings),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Ending Theme',
          style: CommonTypography.roboto16.copyWith(
              color: CommonColors.black21
          ),
        ),
        ..._buildListTheme(themes: endings),
      ],
    );
  }

  List<Widget> _buildListTheme({
    required List<String> themes,
  }) {
    List<Widget> listTheme = [];
    for (var element in themes) {
      var itemTheme = Row(
        children: [
          const Icon(
            Icons.play_circle_outline,
            color: CommonColors.greyBD,
            size: 30,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              '"$element"'
            ),
          )
        ],
      );

      listTheme.add(itemTheme);
    }

    return listTheme;
  }

  Widget _buildCommonText({
    required String label,
    Color labelColor = CommonColors.black21,
    required String value,
    Color valueColor = CommonColors.black21,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: CommonTypography.roboto16.copyWith(
            color: labelColor,
          ),
        ),
        Text(
          value,
          style: CommonTypography.roboto16.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }

  Widget _buildFailedDetail({
    required DetailState state,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      child: const CommonErrorState(),
    );
  }

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: CommonColors.greyD1,
                  highlightColor: CommonColors.greyBD,
                  child: Container(
                    height: 320,
                    width: 220,
                    color: CommonColors.greyD1,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 24,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 28,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 20,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 22,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 20,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 22,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 20,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 22,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 20,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Shimmer.fromColors(
                      baseColor: CommonColors.greyD1,
                      highlightColor: CommonColors.greyBD,
                      child: Container(
                        height: 22,
                        width: 100,
                        color: CommonColors.greyD1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 30,
                color: CommonColors.greyD1,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 36,
                color: CommonColors.greyD1,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 30,
                color: CommonColors.greyD1,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 100,
                color: CommonColors.greyD1,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 250,
                color: CommonColors.greyD1,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

}