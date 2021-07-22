class Notes {
  final String? id;
  String? title;
  String? content;
  String videoLink;
  bool? isVideoAdded;
  bool isDeleted;
  Notes(
      {this.id,
      required this.videoLink,
      required this.title,
      required this.content,
      required this.isVideoAdded,
      required this.isDeleted});
}
