import 'package:blog_application/models/like_notifier.dart';
import 'package:blog_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.likeNotifier,
  }) : super(key: key);

  final LikeNotifier likeNotifier;

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<BlogUser>(context).isLoaggedIn;
    return isUserLoggedIn
        ? const SizedBox()
        : TextButton.icon(
            onPressed: () => likeNotifier.likeOrUnlike(),
            icon: Icon(
              likeNotifier.like ? Icons.thumb_up : Icons.thumb_up_outlined,
            ),
            label: Text(
              likeNotifier.like ? "Unlike" : "Like",
            ),
          );
  }
}
