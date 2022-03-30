import 'package:blog_application/blog_entry_page.dart';
import 'package:blog_application/blog_list_tile.dart';
import 'package:blog_application/blog_scaffold.dart';
import 'package:blog_application/login_dialog.dart';
import 'package:blog_application/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_application/blog_post.dart';
import 'package:blog_application/constrained_center.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogPosts = Provider.of<List<BlogPost>>(context);
    final user = Provider.of<BlogUser>(context);
    return BlogScaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (user.isLoaggedIn) {
                FirebaseAuth.instance.signOut();
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LoginDialog();
                  },
                );
              }
            },
            child:
                user.isLoaggedIn ? const Text("Logout") : const Text("Login"),
          )
        ],
      ),
      floatingActionButton: user.isLoaggedIn
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const BlogEntryPage();
                    },
                  ),
                );
              },
              label: const Text("New Blog"),
              icon: const Icon(Icons.add),
            )
          : const SizedBox(),
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              user.profilePicture,
            ),
            radius: 72,
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        ConstrainedCenter(
          child: SelectableText(
            user.name,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SelectableText(
          'Hi I m Rohit, I am flutter develooper and occasionaly i nap',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 40,
        ),
        SelectableText(
          'Blog',
          style: Theme.of(context).textTheme.headline2,
        ),
        for (var post in blogPosts)
          BlogListTile(
            blog: post,
          ),
      ],
    );
  }
}
