import 'package:blog_application/blog_post.dart';
import 'package:blog_application/home_page.dart';
import 'package:blog_application/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 45, fontWeight: FontWeight.w800, color: Colors.black),
    headline2: TextStyle(
        fontSize: 27, fontWeight: FontWeight.w700, color: Colors.black),
    bodyText2: TextStyle(fontSize: 22, height: 1.4),
    caption: TextStyle(fontSize: 18, height: 1.4),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<BlogPost>>(
          create: (context) => blogPosts(),
          initialData: const [],
          lazy: true,
        ),
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
        ProxyProvider<User?, BlogUser>(
          create: (context) => BlogUser(
            profilePicture:
                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
            name: "Rohit Agarwal",
            isLoaggedIn: false,
          ),
          update: (context, User? firebaseUser, blogUser) {
            return BlogUser(
              profilePicture: blogUser!.profilePicture,
              name: blogUser.name,
              isLoaggedIn: firebaseUser != null,
            );
          },
        ),
        Provider<ThemeData>(create: (context) => theme),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Blog App",
          theme: Provider.of<ThemeData>(context),
          home: const HomePage(),
        );
      },
    );
  }
}

Stream<List<BlogPost>> blogPosts() {
  return FirebaseFirestore.instance
      .collection("blogs")
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) => BlogPost.fromJson(e)).toList()
      ..sort((first, last) {
        final firstDate = first.publishedDate;
        final lastDate = last.publishedDate;
        return lastDate.compareTo(firstDate);
      });
  });
}
