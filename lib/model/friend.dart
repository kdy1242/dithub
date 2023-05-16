
class Friend {
  String uid;
  String email;
  String name;
  String? profileImg;

  Friend({
    required this.uid,
    required this.email,
    required this.name,
    this.profileImg,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name': this.name,
      'profileImg': this.profileImg,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileImg: map['profileImg'],
    );
  }
}
