import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';

import '../models/story_model.dart';

class StoryViewer extends StatelessWidget {
  final Story story;
  final VideoPlayerController? videoController;

  StoryViewer({
    required this.story,
    this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    if (story.type == StoryType.image) {
      return CachedNetworkImage(
        imageUrl: story.url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    } else if (story.type == StoryType.video) {
      return videoController != null && videoController!.value.isInitialized
          ? AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: VideoPlayer(videoController!),
      )
          : Center(child: CircularProgressIndicator());
    }
    return Container();
  }
}
