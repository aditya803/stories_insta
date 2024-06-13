import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'Data/data.dart';
import 'models/story_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StoryScreen(stories: stories),
    );
  }
}

class StoryScreen extends StatefulWidget {
  final List<Story> stories;

  const StoryScreen({required this.stories});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late PageController _pageController;
  late VideoPlayerController _videoPlayerController;
  int _currIndex = 0;

  @override
  void initState(){
    super.initState();
    _pageController = PageController();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.stories[2].url))
      ..initialize().then((value) => setState(() {}));
    _videoPlayerController.play();
  }
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        child: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.stories.length,
          itemBuilder: (context,i){
            final Story story = widget.stories[i];
            switch(story.mediaType){
              case MediaType.image:
                return CachedNetworkImage(
                    imageUrl: story.url,
                    fit: BoxFit.cover,
                );
              case MediaType.video:
                if(_videoPlayerController != null &&
                   _videoPlayerController.value.isInitialized){
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoPlayerController.value.size.width,
                      height: _videoPlayerController.value.size.height,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  );
                }
            }
            return const SizedBox.shrink();
          },

        ),
      ),
    );
  }
  void _onTapDown(TapDownDetails details, Story story){
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if(dx < screenWidth/3){
      setState(() {
        if(_currIndex -1 >=0){
          _currIndex-= 1;
        }
      });
    }else if(dx>2*screenWidth / 3){
      setState(() {
        if(_currIndex + 1 < widget.stories.length){
          _currIndex += 1;
        }else{
          _currIndex = 0;
        }
      });
    }else{
      if(story.mediaType == MediaType.video){
        if(_videoPlayerController.value.isPlaying){
          _videoPlayerController.pause();
        }else{
          _videoPlayerController.play();
        }
      }
    }
  }
}


