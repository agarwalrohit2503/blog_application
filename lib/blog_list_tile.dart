import 'package:blog_application/blog_entry_page.dart';
import 'package:blog_application/blog_page.dart';
import 'package:blog_application/blog_post.dart';
import 'package:blog_application/like_button.dart';
import 'package:blog_application/like_notifier.dart';
import 'package:blog_application/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListTile extends StatelessWidget {
  final BlogPost blog;
  BlogListTile({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<BlogUser>(context).isLoaggedIn;
    return ChangeNotifierProvider<LikeNotifier>(
      create: (context) => LikeNotifier(blog)..init(),
      builder: (context, child) {
        final likeNotifier = Provider.of<LikeNotifier>(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                blog.title,
                style: TextStyle(
                  color: Colors.blueAccent.shade700,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      child: BlogPage(blog: blog),
                      value: likeNotifier,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SelectableText(
                  blog.formattedDate,
                  style: Theme.of(context).textTheme.caption,
                ),
                const Spacer(),
                LikeButton(likeNotifier: likeNotifier),
                SizedBox(width: isUserLoggedIn ? 10 : 0),
                isUserLoggedIn
                    ? PopupMenuButton<Action>(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              child: Text("Edit"),
                              value: Action.edit,
                            ),
                            const PopupMenuItem(
                              child: Text("Delete"),
                              value: Action.delete,
                            ),
                          ];
                        },
                        onSelected: (Action value) {
                          switch (value) {
                            case Action.edit:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BlogEntryPage(blogPost: blog),
                                ),
                              );
                              break;
                            case Action.delete:
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      contentPadding: const EdgeInsets.all(18),
                                      children: [
                                        const Text(
                                            "Are you sure want to delete this blog"),
                                        Text(
                                          blog.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('blogs')
                                                    .doc(blog.id)
                                                    .delete()
                                                    .then(
                                                      (value) => Navigator.pop(
                                                          context),
                                                    );
                                              },
                                              child: const Text("Delete"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel")),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                              break;
                            default:
                          }
                        },
                      )
                    : const SizedBox()
              ],
            ),
            const Divider(thickness: 2),
          ],
        );
      },
    );
  }
}

enum Action { edit, delete }
