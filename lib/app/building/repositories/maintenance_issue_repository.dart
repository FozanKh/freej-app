import '../models/maintenance_issue.dart';
import '../services/building_services.dart';

class MaintenanceIssueRepository {
  MaintenanceIssueRepository._();
  static MaintenanceIssueRepository? _instance;
  static MaintenanceIssueRepository get instance => _instance ??= MaintenanceIssueRepository._();
  List<MaintenanceIssue> _maintenanceIssues = [];

  Future<void> init() async {
    await getAllMaintenanceIssues(refresh: true);
  }

  Future<List<MaintenanceIssue>> getAllMaintenanceIssues({bool refresh = false}) async {
    if (_maintenanceIssues.isEmpty || refresh) {
      _maintenanceIssues = await BuildingServices.getAllMaintenanceIssues();
      _maintenanceIssues.sort();
      return _maintenanceIssues;
    } else {
      return _maintenanceIssues;
    }
  }

  void updateObject(MaintenanceIssue issue) {
    _maintenanceIssues.removeWhere((element) {
      return element.id == issue.id;
    });
    _maintenanceIssues.add(issue);
    _maintenanceIssues.sort();
  }

  void clear() {
    _maintenanceIssues.clear();
  }
}
