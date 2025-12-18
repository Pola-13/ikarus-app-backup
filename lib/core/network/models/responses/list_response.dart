import 'package:ikarusapp/core/extensions/json_parser.dart';

class ListResponse<T> {
  final bool? isSuccessful;
  final String? responseCode;
  final List<T>? data;
  final String? message;
  final Map<String, dynamic>? errors;

  ListResponse({
    this.isSuccessful,
    this.responseCode,
    this.data,
    this.message,
    this.errors,
  });

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    // Support new structure with is_successful + data.results
    final isSuccessful = json['is_successful'] as bool?;
    final responseCode = json['response_code'] as String?;

    // Extract message (can be nested object)
    String? message;
    if (json['message'] != null) {
      if (json['message'] is Map) {
        message = json['message']['message'] as String?;
      } else if (json['message'] is String) {
        message = json['message'] as String?;
      }
    }

    // Extract errors
    Map<String, dynamic>? errors;
    if (json['errors'] != null && json['errors'] is Map) {
      errors = json['errors'] as Map<String, dynamic>;
    }

    // Extract list data
    // New format: data is directly a list, or data.results, or results at root
    List<dynamic>? resultsSource;
    
    if (json['data'] != null) {
      if (json['data'] is List) {
        // Data is directly a list (e.g., countries API)
        resultsSource = json['data'] as List<dynamic>;
      } else if (json['data'] is Map && json['data']['results'] != null) {
        // Data is an object with results property
        resultsSource = json['data']['results'] as List<dynamic>;
      }
    } else if (json['results'] != null) {
      // Fallback: results at root level
      resultsSource = json['results'] as List<dynamic>;
    }

    final parsedData = resultsSource != null
        ? resultsSource
            .map((i) => (i as Map<String, dynamic>).parse<T>())
            .whereType<T>()
            .toList()
        : null;

    return ListResponse(
      isSuccessful: isSuccessful,
      responseCode: responseCode,
      data: parsedData,
      message: message,
      errors: errors,
    );
  }
}
