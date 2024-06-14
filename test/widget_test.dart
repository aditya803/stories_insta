import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:stories_insta/main.dart';
import 'package:stories_insta/models/story_model.dart';
import 'package:stories_insta/models/user_model.dart';
import 'package:stories_insta/provider/user_provider.dart';
import 'package:stories_insta/screens/user_story_view_screen.dart';

void main() {
  testWidgets('User can navigate between stories', (WidgetTester tester) async {
    // Initialize the app
    await tester.pumpWidget(MyApp()); // Replace MyApp() with your app's widget

    // Get the UserProvider
    final userProvider = Provider.of<UserProvider>(tester.element(find.byType(UserStoryViewScreen)));

    // Mock data
    userProvider.currentUser = User(
      id: 1,
      name: 'Test User',
      avatarUrl: 'https://example.com/avatar.jpg',
      stories: [
        Story(id: 1, url: 'https://example.com/story1.jpg', duration: 5, type: StoryType.image),
        Story(id: 2, url: 'https://example.com/story2.jpg', duration: 5, type: StoryType.image),
      ],
    );

    // Build the widget
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: userProvider,
        child: MaterialApp(
          home: UserStoryViewScreen(userIndex: 0),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Test User'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget); // Assuming Image widget is used to display stories

    // Navigate to the next story
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Verify that the next story is displayed
    expect(find.byType(Image), findsOneWidget);

    // Repeat for other interactions (e.g., navigating to previous story, auto-advancing, etc.)
  });
}
