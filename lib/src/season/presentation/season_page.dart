import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fms/src/detail/presentation/arg/detail_arg.dart';
import 'package:fms/src/search/domain/model/search_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_ui/utils/colors/common_colors.dart';
import '../../../common_ui/utils/text_style/common_text_style.dart';
import '../../../common_ui/widgets/common_state/common_error_state.dart';
import '../../animelist/presentation/add_anime/add_anime_page.dart';
import '../../animelist/presentation/add_anime/arg/animelist_arg.dart';
import '../../detail/domain/model/detail_dto.dart';
import '../../detail/presentation/detail_page.dart';
import 'bloc/season_bloc.dart';

class SeasonPage extends StatefulWidget {
  static const route = '/season';

  const SeasonPage({Key? key}) : super(key: key);

  @override
  State<SeasonPage> createState() => _SeasonPageState();
}

class _SeasonPageState extends State<SeasonPage> {
  late Size _size;

  late SeasonBloc _seasonBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _seasonBloc = SeasonBloc(seasonUseCase: GetIt.instance())
    ..add(const SeasonInitEvent(
        page: 1));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_seasonBloc.stateData.seasonDto.length <
          _seasonBloc.stateData.total) {
        _seasonBloc.isLoadingPagination = true;
        _seasonBloc.add(SeasonInitEvent(
          page: _seasonBloc.stateData.currentPage + 1),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocConsumer<SeasonBloc, SeasonState>(
            bloc: _seasonBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if(state is SeasonFailedState) {
                return Column(
                  children: [
                    _buildFailedSeason(state: state),
                    ElevatedButton(
                      onPressed: () {
                        _seasonBloc.add(const SeasonInitEvent(
                            page: 1,
                        ));
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                );
              } else if (state is SeasonLoadingState) {
                return _buildShimmerLoading();
              } else if (state is SeasonEmptyState) {
                return _buildEmptySeason(state: state);
              } else if(state is SeasonSuccessState || state is SeasonPaginationLoadingState || state is GetAnimeLocalSuccessState) {
                return _buildListSeason(state: state);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListSeason({
    required SeasonState state,
  }) {
    final double itemHeight = (_size.height - kBottomNavigationBarHeight) / 2.2;
    final double itemWidth = (_size.width - 24) / 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      controller: _scrollController,
      itemCount: state.data.seasonDto.length,
      itemBuilder: (context, index) {
        bool lastIndex = index == _seasonBloc.stateData.total - 1;

        if(index < _seasonBloc.stateData.seasonDto.length - 1 || lastIndex) {
          _seasonBloc.add(GetAnimeLocalEvent(
            malId: state.data.seasonDto[index].malId
          ));

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailPage.route,
                arguments: DetailArg(
                  id: state.data.seasonDto[index].malId
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 184,
                      height: 240,
                      child: Image.network(
                        state.data.seasonDto[index].image,
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
                    Positioned(
                      bottom: 10,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${state.data.seasonDto[index].score}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: CommonColors.white,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  NumberFormat("#,###").format(state.data.seasonDto[index].members),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Icon(
                                  Icons.group_rounded,
                                  color: CommonColors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<SeasonBloc, SeasonState>(
                      bloc: _seasonBloc,
                      builder: (context, state) {
                        if(state is GetAnimeLocalSuccessState && state.data.seasonDto[index].isInDB == true) {
                          return Positioned(
                            bottom: 15,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              color: CommonColors.blue9F,
                              padding: const EdgeInsets.all(0),
                              child: IconButton(
                                onPressed: () {
                                  SearchDto searchDto = state.data.seasonDto[index];
                                  DetailDto detailDto = DetailDto(
                                    id: searchDto.id ?? 0,
                                    malId: searchDto.malId,
                                    title: searchDto.title,
                                    image: searchDto.image,
                                    type: searchDto.type,
                                    season: searchDto.season,
                                    year: searchDto.year,
                                    score: searchDto.score.toDouble(),
                                    episode: searchDto.episode,
                                  );

                                  Navigator.pushNamed(
                                    context,
                                    AddAnimePage.route,
                                    arguments: AnimelistArg(
                                      detailDto: detailDto,
                                      progressEpisode: searchDto.progressEpisode,
                                      userScore: searchDto.userScore,
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: CommonColors.white,
                                ),
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  state.data.seasonDto[index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CommonTypography.body.copyWith(
                    color: CommonColors.black21,
                    fontSize: 15
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  state.data.seasonDto[index].genres.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CommonTypography.caption.copyWith(
                    color: CommonColors.grey75,
                    fontSize: 13
                  ),
                ),
              ],
            ),
          );
        } else if(_seasonBloc.stateData.seasonDto.length != _seasonBloc.stateData.total) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return const SizedBox.shrink();
      }
    );
  }

  Widget _buildFailedSeason({
    required SeasonState state,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      child: const CommonErrorState(),
    );
  }

  Widget _buildEmptySeason({
    required SeasonState state,
  }) {
    return Expanded(
        child: Center(
          child: Text(
            'Dunia hancur?',
            style: CommonTypography.heading7.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
    );
  }

  Widget _buildShimmerLoading() {
    final double itemHeight = (_size.height - kBottomNavigationBarHeight) / 2.28;
    final double itemWidth = (_size.width - 24) / 2;

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: CommonColors.greyD1,
                highlightColor: CommonColors.greyBD,
                child: Container(
                  height: 240,
                  color: CommonColors.greyD1,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Shimmer.fromColors(
                baseColor: CommonColors.greyD1,
                highlightColor: CommonColors.greyBD,
                child: Container(
                  height: 30,
                  color: CommonColors.greyD1,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Shimmer.fromColors(
                baseColor: CommonColors.greyD1,
                highlightColor: CommonColors.greyBD,
                child: Container(
                  height: 15,
                  color: CommonColors.greyD1,
                ),
              ),
            ],
          );
        }
    );
  }
}