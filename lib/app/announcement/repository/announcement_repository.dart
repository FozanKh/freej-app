import '../models/announcement.dart';
import '../models/commercial_announcement.dart';
import '../services/announcement_services.dart';

class AnnouncementRepository {
  AnnouncementRepository._();
  static AnnouncementRepository? _instance;
  static AnnouncementRepository get instance => _instance ??= AnnouncementRepository._();
  List<Announcement> _announcement = [];
  List<CommercialAnnouncement> _commercialAnnouncements = [];

  Future<void> init() async {
    await getAllAnnouncements(refresh: true);
  }

  Future<List<Announcement>> getAllAnnouncements({bool refresh = false}) async {
    if (_announcement.isEmpty || refresh) {
      _announcement = await AnnouncementServices.getAllAnnouncements();
      _announcement.addAll(await AnnouncementServices.getAllCommercialAnnouncements());
    }
    return _announcement;
  }

  Future<List<CommercialAnnouncement>> getAllCommercialAnnouncements({bool refresh = false}) async {
    if (_commercialAnnouncements.isEmpty || refresh) {
      return _commercialAnnouncements = await AnnouncementServices.getAllCommercialAnnouncements();
    } else {
      return _commercialAnnouncements;
    }
  }

  void clear() {
    _announcement.clear();
    _commercialAnnouncements.clear();
  }
}
