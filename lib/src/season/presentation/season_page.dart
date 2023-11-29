import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fms/src/detail/presentation/arg/detail_arg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_ui/utils/colors/common_colors.dart';
import '../../../common_ui/utils/text_style/common_text_style.dart';
import '../../../common_ui/widgets/common_state/common_error_state.dart';
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

  late SeasonBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = SeasonBloc(seasonUseCase: GetIt.instance())
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
      if (_bloc.stateData.seasonDto.length <
          _bloc.stateData.total) {
        _bloc.isLoadingPagination = true;
        _bloc.add(SeasonInitEvent(
            page: _bloc.stateData.currentPage + 1),
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
            bloc: _bloc,
            listener: (context, state) {},
            builder: (context, state) {
              if(state is SeasonFailedState) {
                return Column(
                  children: [
                    _buildFailedSeason(state: state),
                    ElevatedButton(
                      onPressed: () {
                        _bloc.add(const SeasonInitEvent(
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
              }

              return _buildListSeason(state: state);
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
        bool lastIndex = index == _bloc.stateData.total - 1;

        if(index < _bloc.stateData.seasonDto.length - 1 || lastIndex) {
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
        } else if(_bloc.stateData.seasonDto.length != _bloc.stateData.total) {
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