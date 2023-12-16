import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';
import 'package:fms/src/detail/domain/model/detail_dto.dart';
import 'package:get_it/get_it.dart';

import '../../../../common_ui/widgets/common_state/common_error_state.dart';
import '../../../detail/presentation/arg/detail_arg.dart';
import '../../../detail/presentation/detail_page.dart';
import '../add_anime/add_anime_page.dart';
import '../add_anime/arg/animelist_arg.dart';
import 'bloc/list_anime_bloc.dart';

class ListAnimePage extends StatefulWidget {
  static const route = '/animelist';

  const ListAnimePage({Key? key}) : super(key: key);

  @override
  State<ListAnimePage> createState() => _ListAnimePageState();
}

class _ListAnimePageState extends State<ListAnimePage> {
  late ListAnimeBloc _bloc;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc = ListAnimeBloc(
      listAnimeUseCase: GetIt.instance(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            elevation: 3,
            backgroundColor: CommonColors.blueB5,
            bottom: TabBar(
              indicatorColor: CommonColors.orange00,
              indicatorWeight: 5,
              onTap: (index) {
                setState(() {
                  _tabIndex = index;
                });
              },
              tabs: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Uncompleted',
                    style: CommonTypography.roboto16.copyWith(
                        color: CommonColors.white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Completed',
                    style: CommonTypography.roboto16.copyWith(
                        color: CommonColors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildUncompletedAnimeList(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }

  Widget _buildUncompletedAnimeList() {
    if(_bloc.isFirstLoadingUncompleted) {
      _bloc.add(ListAnimeInitEvent(
          tab: _tabIndex
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocConsumer<ListAnimeBloc, ListAnimeState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is AddAnimeEpisodeLoadingState || state is ReduceAnimeEpisodeLoadingState) {
            _showLoadingForAddReduceProgressEpisode();
          } else if(state is AddAnimeEpisodeSuccessState) {
            Navigator.of(context).pop();
            _showToast(
              message: 'Successfully add episode'
            );
          } else if(state is AddAnimeEpisodeFailedState) {
            Navigator.of(context).pop();
            _showToast(
              message: 'Failed to add episode'
            );
          } else if(state is ReduceAnimeEpisodeSuccessState) {
            Navigator.of(context).pop();
            _showToast(
                message: 'Successfully reduce episode'
            );
          } else if(state is ReduceAnimeEpisodeFailedState) {
            Navigator.of(context).pop();
            _showToast(
                message: 'Failed to reduce episode'
            );
          }
        },
        builder: (context, state) {
          if(state is ListAnimeFailedState) {
            return Column(
              children: [
                _buildFailedListAnime(state: state),
                ElevatedButton(
                  onPressed: () {
                    _bloc.add(const ListAnimeInitEvent(
                      tab: 0,
                    ));
                  },
                  child: const Text('Refresh'),
                ),
              ],
            );
          } else if (state is ListAnimeLoadingState) {
            return _buildShimmerLoading();
          } else if (state is ListAnimeEmptyState) {
            return _buildEmptyListAnime(state: state);
          }

          return _buildListAnime(state: state);
        },
      ),
    );
  }

  Widget _buildListAnime({
    required ListAnimeState state,
  }) {
    return ListView.builder(
      itemCount: state.data.animeEntity.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailPage.route,
              arguments: DetailArg(
                id: state.data.animeEntity[index].malId ?? 0
              ),
            );
          },
          child: Card(
            color: CommonColors.white,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  SizedBox(
                    height: 125,
                    width: 92,
                    child: Image.network(
                      state.data.animeEntity[index].imageUrl ?? '',
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
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    state.data.animeEntity[index].title ?? '',
                                    style: CommonTypography.roboto16.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${state.data.animeEntity[index].type}, ${state.data.animeEntity[index].season} ${state.data.animeEntity[index].year}',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            _buildIconButton(
                                iconData: Icons.edit,
                                onTap: () {
                                  DetailDto detailDto = DetailDto(
                                    id: state.data.animeEntity[index].id ?? 0,
                                    malId: state.data.animeEntity[index].malId ?? 0,
                                    title: state.data.animeEntity[index].title ?? '',
                                    image: state.data.animeEntity[index].imageUrl ?? '',
                                    type: state.data.animeEntity[index].type ?? '',
                                    season: state.data.animeEntity[index].season ?? '',
                                    year: state.data.animeEntity[index].year ?? 0,
                                    score: state.data.animeEntity[index].score?.toDouble() ?? 0,
                                    episode: state.data.animeEntity[index].totalEpisode ?? 0,
                                  );

                                  Navigator.pushNamed(
                                    context,
                                    AddAnimePage.route,
                                    arguments: AnimelistArg(
                                      detailDto: detailDto,
                                      progressEpisode: state.data.animeEntity[index].progressEpisode,
                                      score: state.data.animeEntity[index].score ?? 0,
                                    ),
                                  ).then((_) {
                                    _bloc.add(ListAnimeInitEvent(
                                        tab: _tabIndex
                                    ));
                                  });
                                }
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: state.data.animeEntity[index].totalEpisode == null
                              ? 1 : state.data.animeEntity[index].progressEpisode/(state.data.animeEntity[index].totalEpisode ?? 1),
                          minHeight: 14,
                          color: CommonColors.green50,
                          backgroundColor: CommonColors.greenD9,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: CommonColors.blueE9,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  state.data.animeEntity[index].score.toString(),
                                  style: CommonTypography.roboto16,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${state.data.animeEntity[index].progressEpisode} / ${state.data.animeEntity[index].totalEpisode} ep',
                                  style: CommonTypography.roboto16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                _buildIconButton(
                                    iconData: Icons.remove,
                                    onTap: () {
                                      _bloc.add(ReduceAnimeEpisodeEvent(
                                          id: state.data.animeEntity[index].id ?? 0,
                                          progressEpisode: state.data.animeEntity[index].progressEpisode
                                      ));
                                    }
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                _buildIconButton(
                                  iconData: Icons.add,
                                  onTap: () {
                                    _bloc.add(AddAnimeEpisodeEvent(
                                        id: state.data.animeEntity[index].id ?? 0,
                                        progressEpisode: state.data.animeEntity[index].progressEpisode
                                    ));
                                  }
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildFailedListAnime({
    required ListAnimeState state,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      child: const CommonErrorState(),
    );
  }

  Widget _buildEmptyListAnime({
    required ListAnimeState state,
  }) {
    return Expanded(
        child: Center(
          child: Text(
            'You can add anime to the list',
            style: CommonTypography.heading7.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
    );
  }

  Widget _buildIconButton({
    required IconData iconData,
    required Function() onTap,
  }) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CommonColors.blueE9,
          width: 2.0,
        ),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          iconData,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _showLoadingForAddReduceProgressEpisode() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  void _showToast({
    required String message
  }) {
    Fluttertoast.showToast(
        backgroundColor: CommonColors.whiteF8,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        textColor: CommonColors.black21,
        fontSize: 16.0
    );
  }

}