import 'package:blog_application/models/blog_post.dart';
import 'package:blog_application/common_widgets/blog_scaffold.dart';
import 'package:blog_application/common_widgets/constrained_center.dart';
import 'package:blog_application/common_widgets/like_button.dart';
import 'package:blog_application/models/like_notifier.dart';
import 'package:blog_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  final BlogPost blog;
  const BlogPage({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<BlogUser>(context);
    final likeNotifier = Provider.of<LikeNotifier>(context);
    return BlogScaffold(
      children: [
        ConstrainedCenter(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              user.profilePicture,
            ),
            radius: 54,
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        ConstrainedCenter(
          child: SelectableText(
            user.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        SelectableText(
          blog.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            SelectableText(
              blog.formattedDate,
              style: Theme.of(context).textTheme.caption,
            ),
            const Spacer(),
            LikeButton(likeNotifier: likeNotifier)
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        SelectableText(
          blog.body,
        ),
      ],
    );
  }
}
