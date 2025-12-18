class ApiError {
  final String? message;
  final int? statusCode; // nullable as it is Optional status code

  ApiError({this.message, this.statusCode});

  factory ApiError.fromJson(Map<dynamic, dynamic> json) {
    return ApiError(message: json['message']);
  }
}
