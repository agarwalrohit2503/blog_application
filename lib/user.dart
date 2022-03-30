class BlogUser {
  final String profilePicture;
  final String name;
  final bool isLoaggedIn;
  BlogUser({
    required this.profilePicture,
    required this.name,
    this.isLoaggedIn = false,
  });
}
