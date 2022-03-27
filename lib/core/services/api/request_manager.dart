import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:freej/core/localization/constants.dart';
import 'package:freej/core/util/validate.dart' show validateConnection;
import 'package:freej/core/util/extension.dart' show PrettyJson;
import '../../../app/auth/models/auth_token.dart';
import '../../../app/auth/services/auth_services.dart';
import '../../../main.dart';
import 'api_error.dart';

enum Method { GET, POST, PUT, PATCH, DELETE }

class RequestManger {
  static late AuthToken authToken;
  static String? baseUrl;

  static Future<List<Map<String, dynamic>>> fetchList({
    required String url,
    required Method method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    bool needsAuth = true,
  }) async {
    Map<String, String> headers;
    http.Response res;
    String? query;

    // * Refreshing token if needed
    if (needsAuth && !(authToken.access?.isActive ?? false) && (authToken.refresh?.isActive ?? false)) {
      log('Refreshing Token');
      await AuthServices.refreshAuthTokens(authToken);
    }

    if (needsAuth) {
      headers = {'Authorization': 'Bearer ${authToken.access?.token}'};
    } else {
      headers = {};
    }

    headers['Accept-Language'] = MyApp.currentLocale.toString();
    headers['Content-Type'] = 'application/json';

    if (params != null) {
      query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    }
    if (query != null) url += "?" + query;

    log('URL: $url', name: 'RequestManger/fetchList');
    log('body: ${body?.prettyJson}', name: 'RequestManger/fetchList');

    switch (method) {
      case Method.GET:
        res = await http.get(Uri.parse(url), headers: headers);
        break;
      case Method.POST:
        res = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      case Method.PUT:
        res = await http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      case Method.PATCH:
        res = await http.patch(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      case Method.DELETE:
        res = await http.delete(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      default:
        throw ('unsupported method!');
    }
    if (await validateResponse(response: res)) {
      List<Map<String, dynamic>> result = List<Map<String, dynamic>>.from(jsonDecode(utf8.decode((res.bodyBytes))));
      return result;
    } else {
      throw ('Error, could not validate your information, please try again');
    }
  }

  static Future<Map<String, dynamic>> fetchObject({
    required String url,
    required Method method,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    bool needsAuth = true,
  }) async {
    Map<String, String> headers;
    http.Response res;
    String? query;

    // * Refreshing token if needed
    if (needsAuth && !(authToken.access?.isActive ?? false) && (authToken.refresh?.isActive ?? false)) {
      log('Refreshing Token');
      await AuthServices.refreshAuthTokens(authToken);
    }

    if (needsAuth) {
      headers = {'Authorization': 'Bearer ${authToken.access?.token}'};
    } else {
      headers = {};
    }

    headers['Accept-Language'] = MyApp.currentLocale.toString();
    headers['Content-Type'] = 'application/json';

    if (params != null) {
      query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    }
    if (query != null) url += "?" + query;

    log('URL: $url', name: 'RequestManger/fetchObject');
    log('body: ${body?.prettyJson}', name: 'RequestManger/fetchObject');

    switch (method) {
      case Method.GET:
        res = await http.get(Uri.parse(url), headers: headers);
        break;
      case Method.POST:
        res = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      case Method.PUT:
        res = await http.put(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      case Method.PATCH:
        res = await http.patch(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      case Method.DELETE:
        res = await http.delete(Uri.parse(url), headers: headers, body: jsonEncode(body));
        break;
      default:
        throw ('unsupported method!');
    }
    if (await validateResponse(response: res)) {
      Map<String, dynamic> result = jsonDecode(utf8.decode((res.bodyBytes)));
      return result;
    } else {
      throw ('general_api_error'.translate);
    }
  }

  static Future<bool> validateResponse({required http.Response response}) async {
    log('Response status code = ${response.statusCode}');
    if (await validateConnection() == false) {
      throw ('no_internet_connection'.translate);
    }
    int statusCode = response.statusCode;

    if (statusCode < 300) {
      return true;
    } else if (statusCode == 500) {
      throw ("server_error_500_message".translate);
    } else {
      try {
        ApiError error = ApiError.fromMap(jsonDecode(utf8.decode((response.bodyBytes)))['error']);
        log("error:" + error.toString(), name: "validateResponse/RequestManager");
        if (error.messages.isNotEmpty) {
          throw (error.messages.first);
        } else {
          throw ('general_api_error'.translate);
        }
      } catch (e) {
        if (e is String) {
          rethrow;
        } else {
          throw ('general_api_error'.translate);
        }
      }
    }
  }
}
