import 'package:ikarusapp/core/extensions/json_parser.dart';

class ListResponse<T> {
  final List<T>? data;
  final String? message;

  ListResponse({this.data, this.message});

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    return ListResponse(
      message: json["message"],
      data:
          json['results'] != null
              ? (json['results'])
                  .map((i) => (i as Map<String, dynamic>).parse<T>())
                  .whereType<T>()
                  .toList()
              : null,
    );
  }
}
