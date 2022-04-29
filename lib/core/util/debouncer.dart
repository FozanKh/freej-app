import 'dart:developer';

class Debouncer {
  static Map<Function, int> _debounceActions = {};

  bool debouncing = false;
  static Future<void> debounceEvent(Function action, int seconds) async {
    log("Debouncing : ${action.toString()}");
    log(_debounceActions.toString());

    if (_debounceActions[action] != null && _debounceActions[action]! >= 0) {
      _debounceActions[action] = seconds;
      log("skipping: ${action.toString()}");
      return;
    }
    if (_debounceActions[action] == null) return;

    _debounceActions[action] = seconds;
    while (_debounceActions[action]! > 0) {
      log("debouncing: ${_debounceActions.toString()}");
      _debounceActions[action] = 0;
      await Future.delayed(Duration(seconds: seconds));
    }
    await action.call();
    if (_debounceActions[action] != null) {
      _debounceActions[action] = _debounceActions[action]! - 1;
    }
  }
}
