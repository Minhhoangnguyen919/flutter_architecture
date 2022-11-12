import 'dart:convert';
import 'dart:io';

import 'package:develop_app_hoangnm/core/data/models/profile_model.dart';
import 'package:develop_app_hoangnm/core/data/repositories/account_repository.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateProfileViewModel extends BaseViewModel {
  DataProfileModel? currentDataModel;
  DataProfileModel? editDataModel;

  bool get isEdit =>
      currentDataModel != null && editDataModel != currentDataModel;

  Uint8List? get avatar => editDataModel?.convertAvatar();
  final AccountRepository _accountRepository = AccountRepository();

  XFile? image;
  File? imageRaw;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  final _picker = ImagePicker();

  Future<bool> onPressUpdate() async {
    try {
      final dataNew = DataToUpdate(
        avatar: imageRaw,
        displayName: editDataModel?.displayName,
        lastName: editDataModel?.lastName,
        firstName: editDataModel?.firstName,
        email: editDataModel?.email,
        phoneNumber: editDataModel?.phoneNumber,
        gender: editDataModel?.gender,
        address: editDataModel?.address,
        country: editDataModel?.country,
        dateOfBirth: editDataModel?.dateOfBirth,
        city: editDataModel?.city,
      );
      if (isEdit) {
        final res = await _accountRepository.updateProfile(dataNew);
        if (res != null) {
          // showToastSuccess(res.message);
          return true;
        } else if (res != null && res.status != null && !res.status!) {
          // showToastError(res.message);
        }
      }
      return false;
    } on Exception {
      // showToastError(
      //   Strings.of(context)!.anErrorHasOccurred,
      // );
      return false;
    }
  }

  void initData(DataProfileModel dataDefault) {
    currentDataModel = dataDefault.clone;
    editDataModel = dataDefault.clone;
    nameController.text = editDataModel?.displayName ?? '';
    lastNameController.text = editDataModel?.lastName ?? '';
    firstNameController.text = editDataModel?.firstName ?? '';
    emailController.text = editDataModel?.email ?? '';
    phoneController.text = editDataModel?.phoneNumber ?? '';
    genderController.text = editDataModel?.gender ?? '';
    addressController.text = editDataModel?.address ?? '';
    cityController.text = editDataModel?.city ?? '';
    countryController.text = editDataModel?.country ?? '';

    if (editDataModel != null && editDataModel?.dateOfBirth != null) {
      dateOfBirthController.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(editDataModel!.dateOfBirth!));
      currentDataModel!.dateOfBirth = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(editDataModel!.dateOfBirth!));
      editDataModel!.dateOfBirth = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(editDataModel!.dateOfBirth!));
    } else {
      dateOfBirthController.text = '';
    }
  }

  String? validateFullName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.displayNameRequired;
    }
    return null;
  }

  Future<void> getImage(ImageSource imageSource) async {
    image = await _picker.pickImage(
      source: imageSource,
      imageQuality: 25,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null) {
      imageRaw = File(image!.path);
      List<int> imageBytes = imageRaw!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      editDataModel!.avatar = base64Image;
      updateUI();
    }
  }

  void setEditDataModel() {
    editDataModel?.displayName = nameController.text;
    editDataModel?.lastName = lastNameController.text;
    editDataModel?.firstName = firstNameController.text;
    editDataModel?.dateOfBirth = dateOfBirthController.text;
    editDataModel?.gender = genderController.text;
    editDataModel?.address = addressController.text;
    editDataModel?.city = cityController.text;
    editDataModel?.country = countryController.text;
    notifyListeners();
  }

  void setPhone(String? phone) {
    editDataModel?.phoneNumber = phone;
    notifyListeners();
  }
}
