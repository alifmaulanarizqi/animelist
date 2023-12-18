import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fms/common_ui/widgets/button/primary_button_text_and_icon.dart';
import 'package:fms/common_ui/widgets/dialogs/common_dialogs.dart';
import 'package:fms/core/data/local/database/entities/anime_entity.dart';
import 'package:fms/src/animelist/presentation/add_anime/arg/animelist_arg.dart';
import 'package:fms/src/animelist/presentation/add_anime/bloc/add_anime_bloc.dart';
import 'package:fms/src/detail/domain/model/detail_dto.dart';
import 'package:fms/src/main/main_dashboard/main_dashboard.dart';
import 'package:get_it/get_it.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../common_ui/utils/colors/common_colors.dart';
import '../../../../common_ui/utils/text_style/common_text_style.dart';
import '../../../../common_ui/widgets/appbar/common_appbar.dart';
import '../../../../core/utils/value_extension.dart';
import '../../../main/main_dashboard/args/main_dashboard_arg.dart';

class AddAnimePage extends StatefulWidget {
  static const route = '/animelist/add-anime';

  const AddAnimePage({Key? key}) : super(key: key);

  @override
  State<AddAnimePage> createState() => _AddAnimePageState();
}

class _AddAnimePageState extends State<AddAnimePage> {
  late AddAnimeBloc _bloc;

  late DetailDto _detailDto;
  late int _episodePicker;
  late int _scorePicker;
  String _tabBarTitle = 'Add Anime List';

  @override
  void initState() {
    super.initState();
    _bloc = AddAnimeBloc(addAnimeUseCase: GetIt.instance());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args = cast<AnimelistArg>(
      ModalRoute.of(context)?.settings.arguments,
    );
    DetailDto detailDto = args?.detailDto ?? const DetailDto();
    _detailDto = detailDto;
    if(args?.progressEpisode != null) {
      _tabBarTitle = 'Edit Anime List';
    }
    _episodePicker = args?.progressEpisode ?? 1;
    _scorePicker = args?.userScore ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        textTitle: _tabBarTitle,
        textColor: Colors.white,
        backgroundColor: CommonColors.blueB5,
      ),
      body: SafeArea(
        child: BlocConsumer<AddAnimeBloc, AddAnimeState>(
          bloc: _bloc,
          listener: (context, state) {
            if(state is AddAnimeLoadingState || state is UpdateAnimeLoadingState || state is DeleteAnimeLoadingState) {
              _showLoading();
            } else if(state is AddAnimeSuccessState) {
              _displayToast(
                message: 'Successfully add anime',
              );
              Future.delayed(const Duration(seconds: 1)).then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  MainPage.route,
                  arguments: MainDashboardArg(
                    indexPage: 2
                  ),
                  (route) => false,
                );
              });
            } else if (state is AddAnimeFailedState) {
              Navigator.of(context).pop();
              _displayToast(
                message: state.data.error?.message ?? ''
              );
            } else if (state is UpdateAnimeSuccessState) {
              Navigator.of(context).pop();
              _displayToast(
                message: 'Successfully update anime'
              );
            } else if (state is UpdateAnimeFailedState) {
              Navigator.of(context).pop();
              _displayToast(
                message: state.data.error?.message ?? ''
              );
            } else if (state is DeleteAnimeSuccessState) {
              Navigator.of(context).pop();
              _displayToast(
                message: 'Successfully delete anime'
              );
            } else if (state is DeleteAnimeFailedState) {
              Navigator.of(context).pop();
              _displayToast(
                message: state.data.error?.message ?? ''
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    _detailDto.title,
                    textAlign: TextAlign.center,
                    style: CommonTypography.roboto18.copyWith(
                        color: CommonColors.black21,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Progress Episode',
                      style: CommonTypography.roboto16
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  NumberPicker(
                    value: _episodePicker,
                    axis: Axis.horizontal,
                    minValue: 1,
                    maxValue: _detailDto.episode,
                    itemHeight: 52,
                    itemWidth: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: CommonColors.blue9F),
                    ),
                    onChanged: (value) => setState(() => _episodePicker = value),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Score',
                      style: CommonTypography.roboto16
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  NumberPicker(
                    value: _scorePicker,
                    axis: Axis.horizontal,
                    minValue: 0,
                    maxValue: 10,
                    itemHeight: 52,
                    itemWidth: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: CommonColors.blue9F),
                    ),
                    onChanged: (value) => setState(() => _scorePicker = value),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  PrimaryButtonTextAndIcon(
                    label: 'Save',
                    isActive: true,
                    onTap: () {
                      var animeEntity = AnimeEntity(
                          malId: _detailDto.malId,
                          title: _detailDto.title,
                          imageUrl: _detailDto.image,
                          type: _detailDto.type,
                          season: _detailDto.season,
                          year: _detailDto.year,
                          score: _scorePicker,
                          totalEpisode: _detailDto.episode,
                          progressEpisode: _episodePicker,
                          isCompleted: _episodePicker == _detailDto.episode ? 1 : 0
                      );

                      if(_tabBarTitle == 'Edit Anime List') {
                        animeEntity.id = _detailDto.id;
                        _bloc.add(UpdateAnimeSubmitEvent(animeEntity: animeEntity));
                      } else {
                        _bloc.add(AddAnimeSubmitEvent(animeEntity: animeEntity));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _tabBarTitle == 'Edit Anime List' ?
                  PrimaryButtonTextAndIcon(
                    label: 'Delete From List',
                    isActive: true,
                    backgroundColor: CommonColors.red52,
                    onTap: () {
                      CommonDialogs.showConfirmationDialog(
                        context,
                        title: 'Are you sure want to delete?',
                        btnTextLeft: 'Cancel',
                        btnTextRight: 'Delete',
                        onRightBtnClick: () {
                          var animeEntity = AnimeEntity(
                              id: _detailDto.id,
                              malId: _detailDto.malId,
                              title: _detailDto.title,
                              imageUrl: _detailDto.image,
                              type: _detailDto.type,
                              season: _detailDto.season,
                              year: _detailDto.year,
                              score: _scorePicker,
                              totalEpisode: _detailDto.episode,
                              progressEpisode: _episodePicker,
                              isCompleted: _episodePicker == _detailDto.episode ? 1 : 0
                          );

                          _bloc.add(DeleteAnimeSubmitEvent(animeEntity: animeEntity));
                        }
                      );
                    },
                  ) : const SizedBox.shrink(),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  void _displayToast({
    required String message
  }) {
    Navigator.of(context).pop();
    Fluttertoast.showToast(
        backgroundColor: CommonColors.whiteF8,
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        textColor: CommonColors.black21,
        fontSize: 16.0
    );
  }

  void _showLoading() {
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

}