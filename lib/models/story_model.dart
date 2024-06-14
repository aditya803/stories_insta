enum StoryType { image, video }

class Story {
  final int id;
  final String url;
  final int duration; // Duration in seconds
  final StoryType type;

  Story({
    required this.id,
    required this.url,
    required this.duration,
    required this.type,
  });
}
