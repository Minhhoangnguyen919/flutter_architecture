import 'package:flutter/material.dart';

import 'package:develop_app_hoangnm/core/data/repositories/courses_repository.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/data/models/course_model.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

class ListCoursesViewModel extends BaseViewModel {
  final CoursesRepository _coursesRepository = CoursesRepository();

  List<CoursesModel> courses = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool activeSearch = false;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][LIST_COURSES_VIEW_MODEL] => INIT");
    await _getDataCourses();
  }

  Future<void> _getDataCourses() async {
    // TODO : Handle call API courses
    try {
      _isLoading = true;
      final res = await _coursesRepository.getAllListCourses();
      if (res != null) {
        courses = res;
      } else {
        _showToastMessError();
      }
      _isLoading = false;
      notifyListeners();
    } on Exception {
      _showToastMessError();
      _isLoading = false;
    }
  }

  void _showToastMessError() {
    showToastError(Strings.of(context)!.anErrorHasOccurred);
  }
}
