import '../../../core/services/api/request_manager.dart';
import '../../campus/models/building.dart';
import '../../campus/models/campus.dart';
import '../models/maintenance_issue.dart';

class BuildingServices {
  static final _maintenanceIssuesUrl = "${RequestManger.baseUrl}/campuses/residents/me/building-issues/";
  static final _fixMaintenanceIssueUrl = "${RequestManger.baseUrl}/campuses/residents/me/fix-building-issues/<pk>/";
  static final _buildingsUrl = "${RequestManger.baseUrl}/campuses/<pk>/buildings/";
  static final _campusesUrl = "${RequestManger.baseUrl}/campuses/";

  static Future<List<Campus>> getAllCampuses() async {
    return (await RequestManger.fetchList(
      url: _campusesUrl,
      method: Method.GET,
      needsAuth: false,
    ))
        .map((e) => Campus.fromMap(e))
        .toList();
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

  static Future<List<MaintenanceIssue>> getAllMaintenanceIssues() async {
    return (await RequestManger.fetchList(
      url: _maintenanceIssuesUrl,
      method: Method.GET,
    ))
        .map((e) => MaintenanceIssue.fromMap(e))
        .toList();
  }

  static Future<MaintenanceIssue> fixMaintenanceIssue(MaintenanceIssue issue) async {
    return MaintenanceIssue.fromMap(await RequestManger.fetchObject(
      url: _fixMaintenanceIssueUrl.replaceAll("<pk>", issue.id.toString()),
      method: Method.POST,
    ));
  }

  static Future<MaintenanceIssue> createMaintenanceIssue(MaintenanceIssueType type, String description) async {
    Map<String, dynamic> body = {
      "type": type.name,
      "description": description,
    };
    return MaintenanceIssue.fromMap(
      await RequestManger.fetchObject(
        url: _maintenanceIssuesUrl,
        method: Method.POST,
        body: body,
      ),
    );
  }
}
