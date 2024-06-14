import 'package:flutter/material.dart';
import '../Data/data.dart';
import '../models/user_model.dart';
import '../models/story_model.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  int _currentUserIndex = 0;
  int _currentStoryIndex = 0;

  List<User> get users => _users;
  User get currentUser => _users[_currentUserIndex];
  int get currentStoryIndex => _currentStoryIndex;
  Story get currentStory => currentUser.stories[_currentStoryIndex];

  set currentUser(User? user){
    currentUser = user;
    notifyListeners();
  }

  Future<void> fetchUsersWithStories() async {
    _users = await RemoteDataSource().fetchUsersWithStories();
    notifyListeners();
  }

  void resetIndexes() {
    _currentUserIndex = 0;
    _currentStoryIndex = 0;
    notifyListeners();
  }

  void nextStory() {
    if (_currentStoryIndex < currentUser.stories.length - 1) {
      _currentStoryIndex++;
    } else {
      _currentStoryIndex = 0;
      nextUser();
    }
    notifyListeners();
  }

  void previousStory() {
    if (_currentStoryIndex > 0) {
      _currentStoryIndex--;
    } else {
      _currentStoryIndex = currentUser.stories.length - 1;
      previousUser();
    }
    notifyListeners();
  }

  void nextUser() {
    if (_currentUserIndex < _users.length - 1) {
      _currentUserIndex++;
    } else {
      _currentUserIndex = 0;
    }
    _currentStoryIndex = 0;
    notifyListeners();
  }

  void previousUser() {
    if (_currentUserIndex > 0) {
      _currentUserIndex--;
    } else {
      _currentUserIndex = _users.length - 1;
    }
    _currentStoryIndex = 0;
    notifyListeners();
  }
}
