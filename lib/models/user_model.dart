import 'package:stories_insta/models/story_model.dart';


class User {
  final int id;
  final String name;
  final String avatarUrl;
  final List<Story> stories;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.stories,
  });
}
