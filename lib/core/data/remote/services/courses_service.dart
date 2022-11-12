import 'package:develop_app_hoangnm/core/data/models/course_model.dart';
import 'package:develop_app_hoangnm/core/data/remote/services/base_service.dart';
import 'package:develop_app_hoangnm/core/mock_datas/mock_courses_data.dart';

class CoursesService extends BaseService {
  Future<List<CoursesModel>?> getAllListCourses() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return MockDataCourses.courses;
  }

  Future<List<CommentModel>> getListComment() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return MockDataCourses.comments;
  }
}
