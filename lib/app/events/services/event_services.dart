import '../../../core/services/api/request_manager.dart';
import '../models/event.dart';

class EventServices {
  static final _eventsUrl = '${RequestManger.baseUrl}/events/';
  static final _eventUrl = '${RequestManger.baseUrl}/events/<pk>/';

  static Future<List<Event>> getAllEvents() async {
    return (await RequestManger.fetchList(url: _eventsUrl, method: Method.GET)).map((e) => Event.fromMap(e)).toList();
  }

  static Future<Event> getEvent(int eventId) async {
    return Event.fromMap(
        await RequestManger.fetchObject(url: _eventUrl.replaceAll('<pk>', eventId.toString()), method: Method.GET));
  }

  static Future<Event> deleteEvent(int eventId) async {
    return Event.fromMap(
        await RequestManger.fetchObject(url: _eventUrl.replaceAll('<pk>', eventId.toString()), method: Method.DELETE));
  }

  static Future<Event> createEvent(
    String name,
    EventType type,
    String description,
    DateTime date, {
    String? locationUrl,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "type": type.name,
      "description": description,
      "location_url": locationUrl,
      "date": date.toIso8601String()
    };
    return Event.fromMap(await RequestManger.fetchObject(url: _eventsUrl, method: Method.POST, body: body));
  }

  static Future<Event> editEvent(Event event) async {
    Map<String, dynamic> body = {
      "name": event.name,
      "type": event.type.name,
      "description": event.description,
      "location_url": event.locationUrl,
      "date": event.date.toIso8601String()
    };
    return Event.fromMap(await RequestManger.fetchObject(url: _eventsUrl, method: Method.POST, body: body));
  }
}
