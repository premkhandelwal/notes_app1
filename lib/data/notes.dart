import 'dart:convert';

class Notes {
  final String? id;
  String? title;
  String? content;
  String? videoLink;
  bool? isVideoAdded;
  bool? isDeleted;
  Notes(
      {this.id,
      this.title,
      this.content,
      this.videoLink,
      this.isVideoAdded,
      this.isDeleted});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'videoLink': videoLink,
      'isVideoAdded': isVideoAdded,
      'isDeleted': isDeleted,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {

    return Notes(
      id: map['Firebase_UID'],
      title: map['Note_Title'],
      content: map['Note_Content'],
      videoLink: map['Video_Link'],
      isVideoAdded: map['isVideoAdded'] == "true",
      isDeleted: map['isDeleted'] == "true",
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notes(id: $id, title: $title, content: $content, videoLink: $videoLink, isVideoAdded: $isVideoAdded, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notes &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.videoLink == videoLink &&
        other.isVideoAdded == isVideoAdded &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        videoLink.hashCode ^
        isVideoAdded.hashCode ^
        isDeleted.hashCode;
  }
}
