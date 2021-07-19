class Notes {
  final String? id;
  String? title;
  String? content;
  bool isDeleted;
  Notes({
    this.id,
    required this.title,
    required this.content,
    required this.isDeleted
  });
}
