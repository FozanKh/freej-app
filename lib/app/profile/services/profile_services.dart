import 'package:freej/app/auth/models/user.dart';
import 'package:freej/core/services/api/request_manager.dart';

class ProfileServices {
  static final _profileUrl = "${RequestManger.baseUrl}/campuses/residents/me/";

  static Future<User> updateProfile(String firstName, String lastName, String mobile) async {
    Map<String, dynamic> body = {
      "first_name": firstName,
      "last_name": lastName,
      "mobile_number": mobile,
    };
    return User.fromMap(await RequestManger.fetchObject(url: _profileUrl, body: body, method: Method.PATCH));
  }
}
