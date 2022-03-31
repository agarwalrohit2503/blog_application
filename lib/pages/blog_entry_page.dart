import 'package:blog_application/models/blog_post.dart';
import 'package:blog_application/common_widgets/blog_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogEntryPage extends StatelessWidget {
  final BlogPost? blogPost;
  const BlogEntryPage({Key? key, this.blogPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    final titleController = TextEditingController(text: blogPost?.title ?? "");
    final bodyController = TextEditingController(text: blogPost?.body ?? "");
    final isEdit = blogPost != null;
    return BlogScaffold(
      children: [
        TextField(
          maxLines: null,
          style: _textTheme.headline1,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Title",
          ),
          controller: titleController,
        ),
        TextField(
          style: _textTheme.bodyText2,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Write your blog here",
          ),
          controller: bodyController,
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final title = titleController.text;
          final body = bodyController.text;
          final _blogPost =
              BlogPost(body: body, title: title, publishedDate: DateTime.now())
                  .toMap();
          if (isEdit) {
            await FirebaseFirestore.instance
                .collection('blogs')
                .doc(blogPost!.id)
                .update(_blogPost);
          } else {
            await FirebaseFirestore.instance.collection('blogs').add(_blogPost);
          }
          Navigator.pop(context);
        },
        label: Text(isEdit ? "Update" : "Submit"),
        icon: Icon(isEdit ? Icons.save : Icons.book),
      ),
    );
  }
}
