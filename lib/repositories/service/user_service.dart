import 'package:chat_demo/repositories/model/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemberService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Member> getMember(String id) async {
    DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(id).get();

    if(doc.data() != null){
      return Member(
        id: doc.data()['id'],
        email: doc.data()['email'],
        name: doc.data()['name'],
        imgUrl: doc.data()['imgUrl'],
      );
    }
    return null;
  }

  Future<void> registerUser(Member member) async {
    _firebaseFirestore.collection('users').doc(member.id).set({
      'id' : member.id,
      'email' : member.email,
      'name' : member.name,
      'imgUrl' : member.imgUrl,
    });
  }
}