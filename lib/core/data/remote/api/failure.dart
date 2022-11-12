class Failure {
  final int? errorCode;
  final String message;

  Failure({this.errorCode, required this.message});

  factory Failure.fromJson(Map<String, dynamic> json) {
    return Failure(
      errorCode: json['errorCode'] as int?,
      message: json['message'] as String,
    );
  }
}
