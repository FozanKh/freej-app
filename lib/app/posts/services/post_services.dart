import '../../../core/services/api/request_manager.dart';
import '../models/post.dart';

class PostServices {
  static final _offersUrl = "${RequestManger.baseUrl}/posts/offers/";
  static final _offerUrl = "${RequestManger.baseUrl}/posts/offers/<pk>/";
  static final _requestsUrl = "${RequestManger.baseUrl}/posts/requests/";
  static final _requestUrl = "${RequestManger.baseUrl}/posts/requests/<pk>/";
  static final _applyUrl = "${RequestManger.baseUrl}/posts/<pk>/applications/";
  static final _cancelApplicationUrl = "${RequestManger.baseUrl}/posts/<pk>/applications/<pk2>/?action=cancel";
  static final _rejectApplicationUrl = "${RequestManger.baseUrl}/posts/<pk>/applications/<pk2>/?action=reject";
  static final _acceptApplicationUrl = "${RequestManger.baseUrl}/posts/<pk>/applications/<pk2>/?action=accept";
  static final _completeApplicationUrl = "${RequestManger.baseUrl}/posts/<pk>/applications/<pk2>/?action=complete";

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

  static Future<Post> createPost(String title, String description, List<String> imagesUrls, PostType type) async {
    Map<String, dynamic> body = {
      "title": title,
      "description": description,
      "images": imagesUrls,
    };

    if (type == PostType.offer) {
      return Post.fromMap(await RequestManger.fetchObject(url: _offersUrl, method: Method.POST, body: body));
    } else {
      return Post.fromMap(await RequestManger.fetchObject(url: _requestsUrl, method: Method.POST, body: body));
    }
  }

  static Future<Post> editPost(Post post, String title, String description, List<String> imagesUrls) async {
    Map<String, dynamic> body = {
      "title": title,
      "description": description,
      "images": imagesUrls,
      "is_active": true,
    };

    if (post.type == PostType.offer) {
      return Post.fromMap(await RequestManger.fetchObject(
          url: _offerUrl.replaceAll("<pk>", post.id.toString()), method: Method.PATCH, body: body));
    } else {
      return Post.fromMap(await RequestManger.fetchObject(
          url: _requestUrl.replaceAll("<pk>", post.id.toString()), method: Method.PATCH, body: body));
    }
  }

  static Future<Post> deActivatePost(Post post, bool isActive) async {
    Map<String, dynamic> body = {
      "title": post.title,
      "description": post.description,
      "images": post.images,
      "is_active": isActive,
    };
    if (post.type == PostType.offer) {
      return Post.fromMap(await RequestManger.fetchObject(
          url: _offerUrl.replaceAll("<pk>", post.id.toString()), method: Method.PATCH, body: body));
    } else {
      return Post.fromMap(await RequestManger.fetchObject(
          url: _requestUrl.replaceAll("<pk>", post.id.toString()), method: Method.PATCH, body: body));
    }
  }

  static Future<Post> deletePost(Post post) async {
    if (post.type == PostType.offer) {
      return Post.fromMap(await RequestManger.fetchObject(
          url: _offerUrl.replaceAll("<pk>", post.id.toString()), method: Method.DELETE));
    } else {
      return Post.fromMap(await RequestManger.fetchObject(
          url: _requestUrl.replaceAll("<pk>", post.id.toString()), method: Method.DELETE));
    }
  }

  static Future<PostApplication> applyForPost(Post post) async {
    return PostApplication.fromMap(
      await RequestManger.fetchObject(url: _applyUrl.replaceAll("<pk>", post.id.toString()), method: Method.POST),
    );
  }

  static Future<PostApplication> cancelPostApplication(Post post, PostApplication application) async {
    return PostApplication.fromMap(
      await RequestManger.fetchObject(
        url:
            _cancelApplicationUrl.replaceAll("<pk>", post.id.toString()).replaceAll("<pk2>", application.id.toString()),
        method: Method.PATCH,
      ),
    );
  }

  static Future<PostApplication> rejectPostApplication(Post post, PostApplication application) async {
    return PostApplication.fromMap(
      await RequestManger.fetchObject(
        url:
            _rejectApplicationUrl.replaceAll("<pk>", post.id.toString()).replaceAll("<pk2>", application.id.toString()),
        method: Method.PATCH,
      ),
    );
  }

  static Future<PostApplication> acceptPostApplication(Post post, PostApplication application) async {
    return PostApplication.fromMap(
      await RequestManger.fetchObject(
        url:
            _acceptApplicationUrl.replaceAll("<pk>", post.id.toString()).replaceAll("<pk2>", application.id.toString()),
        method: Method.PATCH,
      ),
    );
  }

  static Future<PostApplication> completePostApplication(Post post, PostApplication application) async {
    return PostApplication.fromMap(
      await RequestManger.fetchObject(
        url: _completeApplicationUrl
            .replaceAll("<pk>", post.id.toString())
            .replaceAll("<pk2>", application.id.toString()),
        method: Method.PATCH,
      ),
    );
  }
}
