import 'package:blog_application/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeNotifier extends ChangeNotifier {
  final BlogPost blogPost;
  LikeNotifier(this.blogPost);
  bool _isLiked = false;

  bool get like => _isLiked;

  void init() {
    _isLiked = blogPost.isLiked;
  }

  void likeOrUnlike() {
    _isLiked = !_isLiked;
    FirebaseFirestore.instance
        .collection('blogs')
        .doc(blogPost.id)
        .update({'is_liked': _isLiked});
    notifyListeners();
  }
}
