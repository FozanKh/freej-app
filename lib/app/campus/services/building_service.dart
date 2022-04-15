import 'package:freej/app/campus/services/samples.dart';

import '../../../core/services/api/request_manager.dart';
import '../models/building.dart';

class BuildingServices {
  static final _buildingsUrl = "${RequestManger.baseUrl}/campuses/<pk>/buildings/";

  Future<void> init() async {
    await getAllBuildings();
  }

  // TODO: Make [campusId] required
  // TODO: implement real API request
  static Future<List<Building>> getAllBuildings({int campusId = 1}) async {
    return (await RequestManger.fetchList(
      url: _buildingsUrl.replaceAll("<pk>", campusId.toString()),
      method: Method.GET,
      needsAuth: false,
    ))
        .map((e) => Building.fromMap(e))
        .toList();
  }
}
