import '../models/story_model.dart';
import '../models/user_model.dart';

class RemoteDataSource {
  Future<List<User>> fetchUsersWithStories() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      User(
        id: 1,
        name: 'User One',
        avatarUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
        stories: [
          Story(id: 1, url: 'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80', duration: 5, type: StoryType.image),
          Story(id: 2, url: 'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4', duration: 5, type: StoryType.video),
        ],
      ),
      User(
        id: 2,
        name: 'User Two',
        avatarUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
        stories: [
          Story(id: 3, url: 'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80', duration: 5, type: StoryType.image),
          Story(id: 4, url: 'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4', duration: 5, type: StoryType.video),
        ],
      ),
    ];
  }
}
