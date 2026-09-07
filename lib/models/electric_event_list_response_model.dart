import 'package:veneluz_app/models/electric_event_response_model.dart';

class ElectricEventListResponse {
  final List<ElectricEventResponse> events;
  final int count;

  ElectricEventListResponse({this.events = const [], this.count = 0});

  /// Convierte la respuesta json de la API en un objeto ElectricEventListResponse.
  factory ElectricEventListResponse.fromJson(Map<String, dynamic> json) {
    return ElectricEventListResponse(
      events:
          (json['events'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ElectricEventResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      count: json['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'events': events.map((e) => e.toJson()).toList(), 'count': count};
  }
}
