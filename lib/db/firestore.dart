import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts_Social_App');

  // post a message
  Future<void> postMessage(String message) async {
    posts.add({
      'message': message,
      'email': user!.email,
      'timestamp': Timestamp.now(),
    });
  }  
    // read posts whenever there is a change
    Stream<QuerySnapshot> readPosts() {
      final postStream =  posts.orderBy('timestamp', descending: true).snapshots();
      return postStream;
    }
}

