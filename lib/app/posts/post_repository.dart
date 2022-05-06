import 'package:freej/app/posts/services/post_services.dart';

import 'models/post.dart';

class PostRepository {
  PostRepository._();
  static PostRepository? _instance;
  static PostRepository get instance => _instance ??= PostRepository._();
  List<Post> _offers = [];
  List<Post> _requests = [];

  Future<void> init() async {
    await getOffers(refresh: true);
    await getRequests(refresh: true);
  }

  Future<List<Post>> getOffers({bool refresh = false}) async {
    if (_offers.isEmpty || refresh) {
      return _offers = await PostServices.getAllOffers();
    } else {
      return _offers;
    }
  }

  Future<List<Post>> getRequests({bool refresh = false}) async {
    if (_requests.isEmpty || refresh) {
      return _requests = await PostServices.getAllRequests();
    } else {
      return _requests;
    }
  }

  void clear() {
    _offers.clear();
    _requests.clear();
  }
}
