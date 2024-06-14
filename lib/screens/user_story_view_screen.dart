import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/story_model.dart';
import '../provider/user_provider.dart';
import 'package:video_player/video_player.dart';
import '../widget/story_viewer.dart';

class UserStoryViewScreen extends StatefulWidget {
  final int userIndex;

  UserStoryViewScreen({required this.userIndex});

  @override
  _UserStoryViewScreenState createState() => _UserStoryViewScreenState();
}

class _UserStoryViewScreenState extends State<UserStoryViewScreen> {
  late PageController _pageController;
  late UserProvider _userProvider;
  Timer? _timer;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _userProvider.resetIndexes();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeVideoController();
      _startAutoAdvance();
    });
  }

  void _initializeVideoController() {
    final currentStory = _userProvider.currentStory;
    if (currentStory != null && currentStory.type == StoryType.video) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(currentStory.url))
        ..initialize().then((_) {
          setState(() {});
          _videoController?.play();
        });
    }
  }

  void _startAutoAdvance() {
    final currentStory = _userProvider.currentStory;
    if (currentStory != null && currentStory.type == StoryType.image) {
      _timer = Timer.periodic(Duration(seconds: currentStory.duration), (timer) {
        _userProvider.nextStory();
        _pageController.animateToPage(
          _userProvider.currentStoryIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _initializeVideoController();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _videoController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Stack(
            children: [
              GestureDetector(
                onTapUp: (details) {
                  final width = MediaQuery.of(context).size.width;
                  if (details.globalPosition.dx < width / 2) {
                    userProvider.previousStory();
                  } else {
                    userProvider.nextStory();
                  }
                  _pageController.animateToPage(
                    userProvider.currentStoryIndex,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  _initializeVideoController();
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: userProvider.currentUser.stories.length,
                  itemBuilder: (context, index) {
                    final story = userProvider.currentUser.stories[index];
                    return StoryViewer(
                      story: story,
                      videoController: _videoController,
                    );
                  },
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: _buildUserHeader(userProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserHeader(UserProvider userProvider) {
    final user = userProvider.currentUser;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
          radius: 20,
        ),
        SizedBox(width: 10),
        Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
