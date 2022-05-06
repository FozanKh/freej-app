import '../models/event.dart';
import '../services/event_services.dart';

class EventRepository {
  EventRepository._();
  static EventRepository? _instance;
  static EventRepository get instance => _instance ??= EventRepository._();
  List<Event> _events = [];

  Future<void> init() async {
    await getAllEvents(refresh: true);
  }

  Future<List<Event>> getAllEvents({bool refresh = false}) async {
    if (_events.isEmpty || refresh) {
      return _events = await EventServices.getAllEvents();
    } else {
      return _events;
    }
  }

  void clear() {
    _events.clear();
  }
}
