import '../../../core/services/api/request_manager.dart';
import '../models/post.dart';

class PostServices {
  static final _offersUrl = "${RequestManger.baseUrl}/posts/offers/";
  static final _offerUrl = "${RequestManger.baseUrl}/posts/offers/<pk>/";
  static final _requestsUrl = "${RequestManger.baseUrl}/posts/requests/";
  static final _requestUrl = "${RequestManger.baseUrl}/posts/requests/<pk>/";

  static Future<List<Post>> getAllOffers() async {
    return (await RequestManger.fetchList(
      url: _offersUrl,
      method: Method.GET,
    ))
        .map((e) => Post.fromMap(e))
        .toList();
  }

  static Future<List<Post>> getAllRequests() async {
    return (await RequestManger.fetchList(
      url: _requestsUrl,
      method: Method.GET,
    ))
        .map((e) => Post.fromMap(e))
        .toList();
  }
}
