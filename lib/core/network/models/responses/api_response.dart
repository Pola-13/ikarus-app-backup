
import 'package:ikarusapp/core/extensions/json_parser.dart';

class ApiResponse<T> {
  final String? message;
  final T? data;
  final Map<String, List<String>>? errors;

  ApiResponse({this.message, this.data, this.errors});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        message: json['message'],
        data: json['data'] != null && json['data'] is Map
            ? (json['data'] as Map<String, dynamic>).parse<T>()
            : null,
        errors: json['errors']);
  }
}
