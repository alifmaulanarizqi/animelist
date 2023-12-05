import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';
import 'package:fms/common_ui/utils/text_style/common_text_style.dart';
import 'package:fms/src/search/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_ui/widgets/common_state/common_error_state.dart';
import '../../detail/presentation/arg/detail_arg.dart';
import '../../detail/presentation/detail_page.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc _bloc;

  final TextEditingController _textController = TextEditingController();
  bool _isFocused = false;
  String _textSearch = '';
  final FocusNode _focusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = SearchBloc(searchUseCase: GetIt.instance());

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus && _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _scrollController.removeListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (_bloc.stateData.searchDto.length <
          _bloc.stateData.total) {
        _bloc.isLoadingPagination = true;
        _bloc.add(SearchInitEvent(
            page: _bloc.stateData.currentPage + 1),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                focusNode: _focusNode,
                onChanged: (text) {
                  setState(() {
                    _isFocused = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  _bloc.add(SearchInitEvent(
                    page: 1,
                    q: text
                  ));
                },
                decoration: InputDecoration(
                  hintText: 'Search anime',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isFocused
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        _isFocused = false;
                      });
                    },
                  ) : null,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocConsumer<SearchBloc, SearchState>(
                  bloc: _bloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is SearchFailedState) {
                      return Column(
                        children: [
                          _buildFailedSearch(state: state),
                          ElevatedButton(
                            onPressed: () {
                              _bloc.add(SearchInitEvent(
                                page: 1,
                                q: _textSearch
                              ));
                            },
                            child: const Text('Refresh'),
                          ),
                        ],
                      );
                    } else if (state is SearchLoadingState) {
                      return _buildShimmerLoading();
                    } else if (state is SearchEmptyState) {
                      return _buildEmptySearch(state: state);
                    }

                    return _buildListSearch(state: state);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListSearch({
    required SearchState state,
  }) {
    return state.data.searchDto.isEmpty ?
    const Expanded(
      child: Center(
        child: Text('You can search anime'),
      ),
    ) :
    Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.data.searchDto.length,
        itemBuilder: (context, index) {
          bool lastIndex = index == _bloc.stateData.total - 1;

          if(index < _bloc.stateData.searchDto.length - 1 || lastIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailPage.route,
                  arguments: DetailArg(
                      id: state.data.searchDto[index].malId
                  ),
                );
              },
              child: Card(
                color: CommonColors.white,
                elevation: 1,
                child: Row(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 120,
                            child: Image.network(
                              state.data.searchDto[index].image,
                              width: 92,
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
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              color: Colors.black.withOpacity(0.5),
                              child: Row(
                                children: [
                                  Text(
                                    '${state.data.searchDto[index].score}',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              state.data.searchDto[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: CommonTypography.heading8
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: CommonColors.red52,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                    state.data.searchDto[index].type,
                                    style: CommonTypography.body.copyWith(
                                        color: CommonColors.white
                                    )
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                  '${state.data.searchDto[index].episode} ep, ${state.data.searchDto[index].season} ${state.data.searchDto[index].year}',
                                  style: CommonTypography.body
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                '${state.data.searchDto[index].members}',
                                style: CommonTypography.caption.copyWith(
                                    fontSize: 13,
                                    color: CommonColors.grey75
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Icon(
                                Icons.supervisor_account_rounded,
                                size: 22,
                                color: CommonColors.grey75,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if(_bloc.stateData.searchDto.length != _bloc.stateData.total) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return const SizedBox.shrink();
        }
      ),
    );
  }

  Widget _buildFailedSearch({
    required SearchState state,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      child: const CommonErrorState(),
    );
  }

  Widget _buildEmptySearch({
    required SearchState state,
  }) {
    return Expanded(
      child: Center(
        child: Text(
          'Hasil tidak ditemukan',
          style: CommonTypography.heading7.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    );
  }

  Widget _buildShimmerLoading() {
    return Expanded(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if(index == 0)
                  const SizedBox(
                    height: 8,
                  ),
                Shimmer.fromColors(
                  baseColor: CommonColors.greyD1,
                  highlightColor: CommonColors.greyBD,
                  child: Container(
                    height: 120,
                    color: CommonColors.greyD1,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            );
          }
      ),
    );
  }

}