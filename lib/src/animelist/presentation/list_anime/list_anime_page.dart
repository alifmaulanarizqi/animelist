import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';
import 'package:fms/src/detail/domain/model/detail_dto.dart';
import 'package:get_it/get_it.dart';

import '../../../../common_ui/widgets/common_state/common_error_state.dart';
import '../../../../common_ui/widgets/dialogs/common_dialogs.dart';
import '../../../../core/data/local/database/entities/anime_entity.dart';
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
  late ListAnimeBloc _listAnimeBloc;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _listAnimeBloc = ListAnimeBloc(
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
            _buildCompletedAnimeList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUncompletedAnimeList() {
    if(_listAnimeBloc.isFirstLoadingUncompleted) {
      _listAnimeBloc.add(ListAnimeInitEvent(
          tab: _tabIndex
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocConsumer<ListAnimeBloc, ListAnimeState>(
        bloc: _listAnimeBloc,
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
                    _listAnimeBloc.add(const ListAnimeInitEvent(
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

          return _buildListAnime(uncompletedListAnime: state.data.uncompletedAnime);
        },
      ),
    );
  }

  Widget _buildCompletedAnimeList() {
    if(_listAnimeBloc.isFirstLoadingCompleted) {
      _listAnimeBloc.add(ListAnimeInitEvent(
          tab: _tabIndex
      ));
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocConsumer<ListAnimeBloc, ListAnimeState>(
        bloc: _listAnimeBloc,
        listener: (context, state) {
          if (state is AddAnimeEpisodeLoadingState || state is ReduceAnimeEpisodeLoadingState || state is UpdateIsCompletedLoadingState) {
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
          } else if(state is UpdateIsCompletedFailedState) {
            Navigator.of(context).pop();
            _showToast(
                message: 'Failed to move entry to completed'
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
                    _listAnimeBloc.add(const ListAnimeInitEvent(
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

          return _buildListAnime(completedListAnime: state.data.completedAnime);
        },
      ),
    );
  }

  Widget _buildListAnime({
    List<AnimeEntity>? uncompletedListAnime,
    List<AnimeEntity>? completedListAnime,
  }) {
    List<AnimeEntity> listAnime = [];
    if(uncompletedListAnime != null) {
      listAnime.addAll(uncompletedListAnime);
    } else {
      listAnime.addAll(completedListAnime as Iterable<AnimeEntity>);
    }

    return ListView.builder(
      itemCount: listAnime.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailPage.route,
              arguments: DetailArg(
                id: listAnime[index].malId ?? 0
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
                      listAnime[index].imageUrl ?? '',
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
                                    listAnime[index].title ?? '',
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
                                    '${listAnime[index].type}, ${listAnime[index].season} ${listAnime[index].year}',
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
                                    id: listAnime[index].id ?? 0,
                                    malId: listAnime[index].malId ?? 0,
                                    title: listAnime[index].title ?? '',
                                    image: listAnime[index].imageUrl ?? '',
                                    type: listAnime[index].type ?? '',
                                    season: listAnime[index].season ?? '',
                                    year: listAnime[index].year ?? 0,
                                    score: listAnime[index].score?.toDouble() ?? 0,
                                    episode: listAnime[index].totalEpisode ?? 0,
                                  );

                                  Navigator.pushNamed(
                                    context,
                                    AddAnimePage.route,
                                    arguments: AnimelistArg(
                                      detailDto: detailDto,
                                      progressEpisode: listAnime[index].progressEpisode,
                                      userScore: listAnime[index].score ?? 0,
                                    ),
                                  ).then((_) {
                                    _listAnimeBloc.isFirstLoadingUncompleted = true;
                                    _listAnimeBloc.isFirstLoadingCompleted = true;

                                    _listAnimeBloc.add(ListAnimeInitEvent(
                                        tab: _tabIndex
                                    ));
                                  });
                                }
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: listAnime[index].totalEpisode == null
                              ? 1 : listAnime[index].progressEpisode/(listAnime[index].totalEpisode ?? 1),
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
                                  listAnime[index].score.toString(),
                                  style: CommonTypography.roboto16,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${listAnime[index].progressEpisode} / ${listAnime[index].totalEpisode} ep',
                                  style: CommonTypography.roboto16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                uncompletedListAnime != null ?
                                _buildIconButton(
                                    iconData: Icons.remove,
                                    onTap: () {
                                      _listAnimeBloc.add(ReduceAnimeEpisodeEvent(
                                          id: listAnime[index].id ?? 0,
                                          progressEpisode: listAnime[index].progressEpisode
                                      ));
                                    }
                                ) : const SizedBox.shrink(),
                                const SizedBox(
                                  width: 6,
                                ),
                                uncompletedListAnime != null ?
                                _buildIconButton(
                                  iconData: Icons.add,
                                  onTap: () {
                                    _listAnimeBloc.add(AddAnimeEpisodeEvent(
                                      id: listAnime[index].id ?? 0,
                                      progressEpisode: listAnime[index].progressEpisode,
                                      totalEpisode: listAnime[index].totalEpisode ?? 1,
                                    ));

                                    if(listAnime[index].progressEpisode+1 == listAnime[index].totalEpisode) {
                                      CommonDialogs.showConfirmationDialog(
                                          context,
                                          title: 'Move this entry to completed?',
                                          btnTextLeft: 'Cancel',
                                          btnTextRight: 'Move',
                                          onRightBtnClick: () {
                                            _listAnimeBloc.add(UpdateIsCompletedEvent(
                                              id: listAnime[index].id ?? 0,
                                              totalEpisode: listAnime[index].totalEpisode ?? 1,
                                            ));

                                            _listAnimeBloc.isFirstLoadingUncompleted = true;
                                            _listAnimeBloc.isFirstLoadingCompleted = true;
                                            _listAnimeBloc.add(ListAnimeInitEvent(
                                                tab: _tabIndex
                                            ));
                                          }
                                      );
                                    }
                                  }
                                ) : const SizedBox.shrink(),
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