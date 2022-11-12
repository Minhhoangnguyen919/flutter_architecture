
import 'package:develop_app_hoangnm/core/data/models/profile_model.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/ui/shared/app_button.dart';
import 'package:develop_app_hoangnm/ui/shared/app_input.dart';
import 'package:develop_app_hoangnm/ui/shared/app_theme.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_update_profile_view.dart';
import 'package:develop_app_hoangnm/ui/widgets/phone_number_widget.dart';
import 'package:develop_app_hoangnm/view_models/update_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class UpdateProfileView extends BaseView {
  final Function() callBack;
  final DataProfileModel data;

  const UpdateProfileView(
      {Key? key, required this.callBack, required this.data})
      : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState extends BaseViewState<UpdateProfileView,
    UpdateProfileViewModel, DimensUpdateProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<PopupMenuButtonState<String>> _popupButtonKey = GlobalKey();

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().editProfileViewSize;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = UpdateProfileViewModel()..onInitViewModel(context);
    viewModel.initData(widget.data);
  }

  @override
  void calculatorSizeForOtherWidget() {
    viewSize.calculatorRatio<UpdateProfileView>(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.of(context)!.titleAppBarUpdateProfile),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: viewSize.paddingHorizontal,
            vertical: viewSize.paddingVertical),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _showModalBottomSheet();
                },
                child: Stack(
                  children: [_buildImage(), _buildIconEditImage()],
                ),
              ),
            ),
            SizedBox(height: viewSize.spaceVertical),
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildFullNameTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildLastNameTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildFirstNameTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildDateOfBirth(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildGenderTextField(),
                    // _buildButtonPopupMenu(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildPhoneNumberTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildAddressTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildCityTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buildCountryTextField(),
                    SizedBox(
                      height: viewSize.spaceVertical,
                    ),
                    _buttonUpdate(),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Future<T?> _showModalBottomSheet<T>() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: viewSize.paddingContentInBottomModal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(Strings.of(context)!.titleCamera),
                onTap: () =>
                    viewModel.getImage(ImageSource.camera).whenComplete(
                  () {
                    if (viewModel.image != null) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 0,
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(Strings.of(context)!.titleGallery),
                onTap: () =>
                    viewModel.getImage(ImageSource.gallery).whenComplete(
                  () {
                    if (viewModel.image != null) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextCountry,
      hintText: Strings.of(context)!.hintTextCountry,
      controller: viewModel.countryController,
      prefixIcon: const Icon(Icons.public),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildCityTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextCity,
      hintText: Strings.of(context)!.hintTextCity,
      controller: viewModel.cityController,
      prefixIcon: const Icon(Icons.location_city),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildDateOfBirth() {
    return AppInput(
      label: Strings.of(context)!.hintTextDateOfBirth,
      onTap: _showDatePicker,
      controller: viewModel.dateOfBirthController,
      hintText: Strings.of(context)!.hintTextDateOfBirth,
      readOnly: true,
      suffixIcon: Icon(
        Icons.arrow_drop_down,
        size: viewSize.sizeIconSuffix,
      ),
      prefixIcon: const Icon(Icons.calendar_month),
    );
  }

  Future<void> _showDatePicker() async {
    final res = await showDatePicker(
      errorFormatText: Strings.of(context)!.messageErrorDatePicker,
      errorInvalidText: Strings.of(context)!.messageErrorInvalidDatePicker,
      helpText: Strings.of(context)!.titleDatePicker,
      context: context,
      initialDate: viewModel.editDataModel?.dateOfBirth != null
          ? DateTime.parse(viewModel.editDataModel!.dateOfBirth!)
          : DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(3000),
    );
    if (res != null) {
      viewModel.dateOfBirthController.text =
          DateFormat('yyyy-MM-dd').format(res);
      viewModel.setEditDataModel();
    }
  }

  Widget _buildGenderTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextGender,
      readOnly: true,
      onTap: () {
        _popupButtonKey.currentState?.showButtonMenu();
      },
      suffixIcon: _buildButtonPopupMenu(),
      hintText: Strings.of(context)!.hintTextGender,
      controller: viewModel.genderController,
      prefixIcon: const Icon(Icons.transgender),
    );
  }

  Widget _buildButtonPopupMenu() {
    return PopupMenuButton<String>(
      key: _popupButtonKey,
      icon: Icon(
        Icons.arrow_drop_down,
        size: viewSize.sizeIconSuffix,
      ),
      onSelected: (value) {
        viewModel.genderController.text = value;
        viewModel.setEditDataModel();
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: Strings.of(context)!.valueMale,
          child: Text(Strings.of(context)!.valueMale),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.valueFemale,
          child: Text(Strings.of(context)!.valueFemale),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.valueOther,
          child: Text(Strings.of(context)!.valueOther),
        )
      ],
    );
  }

  Widget _buildAddressTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextAddress,
      hintText: Strings.of(context)!.hintTextAddress,
      controller: viewModel.addressController,
      prefixIcon: const Icon(Icons.location_on),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildFullNameTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextDisplayName,
      hintText: Strings.of(context)!.hintTextFullName,
      controller: viewModel.nameController,
      validator: (value) => viewModel.validateFullName(value, context),
      prefixIcon: const Icon(Icons.theater_comedy),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildLastNameTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextLastName,
      hintText: Strings.of(context)!.hintTextLastName,
      controller: viewModel.lastNameController,
      validator: (value) => viewModel.validateFullName(value, context),
      prefixIcon: const Icon(Icons.person),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildFirstNameTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextFirstName,
      hintText: Strings.of(context)!.hintTextFirstName,
      controller: viewModel.firstNameController,
      validator: (value) => viewModel.validateFullName(value, context),
      prefixIcon: const Icon(Icons.person),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildPhoneNumberTextField() {
    return PhoneNumberWidget(
      label: Strings.of(context)!.hintTextPhoneNumber,
      hintText: Strings.of(context)!.hintTextPhoneNumber,
      controller: viewModel.phoneController,
      onChange: (value) {
        viewModel.setPhone(value);
      },
    );
  }

  Widget _buildIconEditImage() {
    return Positioned(
      bottom: viewSize.positionBottomIconImage,
      right: viewSize.positionRightIconImage,
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(viewSize.paddingIconImage),
          color: HexColors.white,
          child: const Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Selector<UpdateProfileViewModel, Uint8List?>(
      selector: (_, viewModel) => viewModel.avatar,
      builder: (_, avatar, __) {
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
          child: avatar != null
              ? CircleAvatar(
                  radius: viewSize.radiusImage,
                  backgroundImage: MemoryImage(avatar), //here
                )
              : CircleAvatar(
                  radius: viewSize.radiusImage,
                  backgroundImage:
                      const AssetImage('assets/images/default_avt.jpg'),
                ),
        );
      },
    );
  }

  Widget _buttonUpdate() {
    return Selector<UpdateProfileViewModel, bool>(
      selector: (_, viewModel) => viewModel.isEdit,
      builder: (_, isEdit, __) {
        return AppButton(
          label: Strings.of(context)!.labelButtonSubmit,
          styleLabel:
              isEdit ? AppText.text24.copyWith(color: HexColors.white) : null,
          backgroundColor: isEdit ? Colors.blue : Colors.white,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final res = await viewModel.onPressUpdate();
              if (isEdit) {
                if (!mounted) return;
                if (res) {
                  widget.callBack();
                  Navigator.of(context).pop();
                }
              }
            }
          },
        );
      },
    );
  }
}
