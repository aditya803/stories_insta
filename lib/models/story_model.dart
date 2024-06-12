import 'package:stories_insta/models/user_model.dart';

enum MediaType{
  image,
  video
}

class Story{
  final String url;
  final MediaType mediaType;
  final Duration duration;
  final User user;

  Story({required this.user, required this.duration, required this.mediaType, required this.url});
}
