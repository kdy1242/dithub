
import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  String id; // 추가: 고유한 식별 아이디
  String uid;
  String title;
  String content;
  DateTime timestamp;
  String? imageUrl;

  Diary({
    required this.id, // 수정: 식별 아이디 필드 추가
    required this.uid,
    required this.title,
    required this.content,
    DateTime? timestamp,
    this.imageUrl,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id, // 수정: 식별 아이디 포함
      'uid': uid,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
    };
  }

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map['id'] as String, // 수정: 식별 아이디 필드 추가
      uid: map['uid'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      imageUrl: map['imageUrl'] as String?,
    );
  }
}
