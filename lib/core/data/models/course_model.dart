class CoursesModel {
  String name;
  String description;
  String image;

  CoursesModel(this.name, this.description, this.image);
}

class CommentModel {
  String author;
  String content;
  String avatarAuthor;

  CommentModel(
      {required this.author,
      required this.content,
      required this.avatarAuthor});
}
