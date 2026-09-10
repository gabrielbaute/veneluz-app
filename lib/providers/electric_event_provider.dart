import 'package:flutter/foundation.dart';

import '../errors/api_exceptions.dart';
import '../models/electric_event_create_model.dart';
import '../models/electric_event_list_response_model.dart';
import '../models/electric_event_response_model.dart';
import '../models/electric_event_update_model.dart';
import '../services/electric_events_service.dart';

class ElectricEventProvider extends ChangeNotifier {
  final ElectricEventsService _electricEventsService;

  ElectricEventListResponse _eventsHistory;

  bool _isLoading = false;
  String? _errorMessage;

  ElectricEventProvider({ElectricEventsService electricEventsService})
}
