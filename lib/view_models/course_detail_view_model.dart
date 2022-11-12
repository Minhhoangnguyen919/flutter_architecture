import 'package:develop_app_hoangnm/core/data/models/course_model.dart';
import 'package:develop_app_hoangnm/core/data/repositories/courses_repository.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/material.dart';

class CourseDetailViewModel extends BaseViewModel {
  final CoursesRepository _coursesRepository = CoursesRepository();

  List<CommentModel> comments = [];

  bool _isLoading = false;

  bool _isLoadMore = false;

  bool get isLoading => _isLoading;

  bool get isLoadMore => _isLoadMore;

  bool hasData = true;

  bool activeSearch = false;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await getListComment();
  }

  Future<void> getListComment({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        _isLoading = true;
      } else {
        _isLoadMore = true;
      }
      notifyListeners();
      final res = await _coursesRepository.getListComment();
      comments.addAll(res);
      _isLoading = false;
      _isLoadMore = false;
      notifyListeners();
    } on Exception {
      _isLoading = false;
      _isLoadMore = false;
    }
  }
}
