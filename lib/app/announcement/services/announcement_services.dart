import '../../../core/services/api/request_manager.dart';
import '../models/announcement.dart';
import '../models/commercial_announcement.dart';

class AnnouncementServices {
  static final _announcementsUrl = "${RequestManger.baseUrl}/announcements/";
  static final _announcementUrl = "${RequestManger.baseUrl}/announcements/<pk>/";
  static final _sendAnnouncementUrl = "${RequestManger.baseUrl}/announcements/send/";
  static final _commercialAnnouncementsUrl = "${RequestManger.baseUrl}/announcements/commercial/";

  static Future<List<Announcement>> getAllAnnouncements() async {
    return (await RequestManger.fetchList(
      url: _announcementsUrl,
      method: Method.GET,
    ))
        .map((e) => Announcement.fromMap(e))
        .toList();
  }

  static Future<List<CommercialAnnouncement>> getAllCommercialAnnouncements() async {
    return (await RequestManger.fetchList(
      url: _commercialAnnouncementsUrl,
      method: Method.GET,
    ))
        .map((e) => CommercialAnnouncement.fromMap(e))
        .toList();
  }

  static Future<Announcement> sendAnnouncement(String title, String description) async {
    Map<String, dynamic> body = {
      "title": title,
      "body": description,
    };
    return Announcement.fromMap(
      await RequestManger.fetchObject(
        url: _sendAnnouncementUrl,
        method: Method.POST,
        body: body,
      ),
    );
  }

  static Future<Announcement> deleteAnnouncement(Announcement announcement) async {
    return Announcement.fromMap(
      await RequestManger.fetchObject(
        url: _announcementUrl.replaceAll("<pk>", announcement.id.toString()),
        method: Method.DELETE,
      ),
    );
  }
}
