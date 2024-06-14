import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stories_insta/screens/user_story_view_screen.dart';
import '../provider/user_provider.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Instagram Stories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),)),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).fetchUsersWithStories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    final user = userProvider.users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserStoryViewScreen(userIndex: index),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(user.avatarUrl),
                              radius: 20.0,
                            ),
                            Text(user.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
