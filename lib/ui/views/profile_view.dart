import 'package:develop_app_hoangnm/view_models/profile_view_model.dart';
import 'package:develop_app_hoangnm/core/data/models/profile_model.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/ui/shared/app_button.dart';
import 'package:develop_app_hoangnm/ui/shared/app_theme.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_profile_view.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/ui/views/update_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class ProfileView extends BaseView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState
    extends BaseViewState<ProfileView, ProfileViewModel, DimensProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().profileViewSize;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ProfileViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.of(context)!.titleAppBarProfile),
        centerTitle: true,
        leading:
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
      ),
      body: Selector<ProfileViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Selector<ProfileViewModel, DataProfileModel?>(
                  selector: (_, viewModel) => viewModel.data,
                  builder: (_, data, __) {
                    return data == null
                        ? Center(
                            child:
                                Text(Strings.of(context)!.defaultValueProfile),
                          )
                        : SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                                horizontal: viewSize.paddingHorizontal,
                                vertical: viewSize.paddingVertical),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: _buildImage(),
                                  ),
                                ),
                                SizedBox(
                                  height: viewSize.spaceVerticalInCenter,
                                ),
                                _displayProfile(
                                    title: Strings.of(context)!
                                        .hintTextDisplayName,
                                    value: data.displayName ??
                                        Strings.of(context)!
                                            .defaultValueProfile),
                                _displayProfile(
                                    title: Strings.of(context)!
                                        .hintTextDateOfBirth,
                                    value: data.dateOfBirth != null
                                        ? DateFormat('yyyy-MM-dd').format(
                                            DateTime.parse(data.dateOfBirth!))
                                        : Strings.of(context)!
                                            .defaultValueProfile),
                                _displayProfile(
                                    title: Strings.of(context)!.hintTextGender,
                                    value: data.gender ??
                                        Strings.of(context)!
                                            .defaultValueProfile),
                                _displayProfile(
                                    title: Strings.of(context)!.hintTextEmail,
                                    value: data.email ??
                                        Strings.of(context)!
                                            .defaultValueProfile),
                                _displayProfile(
                                    title: Strings.of(context)!
                                        .hintTextPhoneNumber,
                                    value: data.phoneNumber ??
                                        Strings.of(context)!
                                            .defaultValueProfile),
                                _displayProfile(
                                    title: Strings.of(context)!.hintTextAddress,
                                    value: data.address ??
                                        Strings.of(context)!
                                            .defaultValueProfile),
                                _displayProfile(
                                    title: Strings.of(context)!.hintTextCountry,
                                    value: data.country ??
                                        Strings.of(context)!
                                            .defaultValueProfile),
                                SizedBox(
                                  height: viewSize.spaceVertical,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: viewSize.spaceVertical),
                                  child: _buttonUpdate(),
                                ),
                              ],
                            ),
                          );
                  },
                );
        },
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: HexColors.white),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: viewModel.data?.convertAvatar() != null
          ? CircleAvatar(
              radius: viewSize.radiusImage,
              backgroundImage:
                  MemoryImage(viewModel.data!.convertAvatar()!), //here
            )
          : CircleAvatar(
              radius: viewSize.radiusImage,
              backgroundImage:
                  const AssetImage('assets/images/default_avt.jpg'),
            ),
    );
  }

  Widget _displayProfile({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: viewSize.paddingBottomDisplayProfile),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppText.text14.copyWith(color: HexColors.grey),
          ),
          SizedBox(
            height: viewSize.spaceVerticalDisplayProfile,
          ),
          Text(value, style: AppText.text18),
        ],
      ),
    );
  }

  Widget _buttonUpdate() {
    return AppButton(
      label: Strings.of(context)!.labelButtonEdit,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateProfileView(
              data: viewModel.profileModel!.data!,
              callBack: () async {
                viewModel.getProfile(isFirstLoad: false);
              },
            ),
          ),
        );
      },
    );
  }
}
