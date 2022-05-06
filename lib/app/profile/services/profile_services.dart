import 'package:freej/app/announcement/repository/announcement_repository.dart';
import 'package:freej/app/auth/models/user.dart';
import 'package:freej/core/services/api/request_manager.dart';

import '../../building/repositories/maintenance_issue_repository.dart';
import '../../campus/models/room.dart';
import '../../events/repositories/event_repository.dart';
import '../../posts/post_repository.dart';

class ProfileServices {
  static final _profileUrl = "${RequestManger.baseUrl}/campuses/residents/me/";

  static Future<User> updateProfile(String firstName, String lastName, String mobile, String? photo, Room? room) async {
    Map<String, dynamic> body = {
      "first_name": firstName,
      "last_name": "-",
      "mobile_number": mobile,
    };
    if (photo != null) {
      body['photo'] = photo;
    }
    if (room != null) {
      body['room_id'] = room.id;
      AnnouncementRepository.instance.init();
      MaintenanceIssueRepository.instance.init();
      EventRepository.instance.init();
      PostRepository.instance.init();
    }
    return User.fromMap(await RequestManger.fetchObject(url: _profileUrl, body: body, method: Method.PATCH));
  }
}
