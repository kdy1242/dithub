
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // 로그인
  login(String email, String password) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).catchError((error) {
      // 로그인 실패
      Get.snackbar('로그인 실패', '아이디와 비밀번호를 다시 확인하세요.');
    });
  }

  // 로그아웃
  logout() => FirebaseAuth.instance.signOut();

  // 회원가입
  signup(String email, String password) => FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password
  );

  // 구글 로그인
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Firestore에 사용자 정보 저장
  saveUserInfoToFirestore(User? user, String email, String name, String profileImageUrl) async {
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.uid,
        'name': user.displayName,
        'profileImg': user.photoURL,
        'createdAt': Timestamp.now(),
      });
    }
  }
}