
import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  String uid;
  String title;
  String content;
  DateTime timestamp;
  String? imageUrl;

  Diary({
    required this.uid,
    required this.title,
    required this.content,
    DateTime? timestamp, // Nullable timestamp parameter
    this.imageUrl,
  }) : timestamp = timestamp ?? DateTime.now(); // Set default value to current time

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
    };
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      uid: map['uid'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      imageUrl: map['imageUrl'] as String?,
    );
  }
}
