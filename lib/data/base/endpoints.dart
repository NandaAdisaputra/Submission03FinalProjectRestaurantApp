import 'base_url.dart' as base_url;

class GetListRestaurant {
  final list = "${base_url.base}/list";
}

class GetPicture {
  final images = "${base_url.base}/images";
}

class GetDetailRestaurant {
  final detail = "${base_url.base}/detail/";
}

class GetSearch {
  final search = "${base_url.base}/search";
}

class PostReview {
  final review = "${base_url.base}/review";
}

final getListRestaurant = GetListRestaurant();
final getPicture = GetPicture();
final getDetailRestaurant = GetDetailRestaurant();
final getSearch = GetSearch();
final postReview = PostReview();
