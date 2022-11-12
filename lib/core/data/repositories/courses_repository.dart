import 'package:develop_app_hoangnm/core/data/models/course_model.dart';
import 'package:develop_app_hoangnm/core/data/remote/services/courses_service.dart';

class CoursesRepository {
  final CoursesService _coursesService = CoursesService();

  Future<List<CoursesModel>?> getAllListCourses() async {
    try {
      return await _coursesService.getAllListCourses();
    } on Exception {
      rethrow;
    }
  }

  Future<List<CommentModel>> getListComment() async {
    try {
      return await _coursesService.getListComment();
    } on Exception {
      rethrow;
    }
  }
}
