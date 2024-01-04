import 'base_url.dart' as BASE_URL;

class _getListRestaurant {
  final list = BASE_URL.base + "/list";
}

class _getPicture {
  final images = BASE_URL.base + "/images";
}

class _getDetailRestaurant {
  final detail = BASE_URL.base + "/detail/";
}

class _getSearch {
  final search = BASE_URL.base + "/search";
}

class _postReview {
  final review = BASE_URL.base + "/review";
}

final getListRestaurant = _getListRestaurant();
final getPicture = _getPicture();
final getDetailRestaurant = _getDetailRestaurant();
final getSearch = _getSearch();
final postReview = _postReview();
