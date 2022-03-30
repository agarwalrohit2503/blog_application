import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final String id;
  final String title;
  final String body;
  final DateTime publishedDate;

  String get formattedDate => DateFormat('MMMM d, y').format(publishedDate);

  BlogPost({
    this.id = '',
    required this.title,
    required this.publishedDate,
    required this.body,
  });

  factory BlogPost.fromJson(DocumentSnapshot blog) {
    final map = blog.data() as Map;

    return BlogPost(
      id: blog.id,
      title: map['title'] ?? "",
      publishedDate: map['published_date'].toDate(),
      body: map['body'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': publishedDate,
    };
  }
}
