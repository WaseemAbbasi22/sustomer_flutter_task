import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sustomer_flutter_task/models/question_model.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final String ?uid;

  FirestoreService({this.uid});

  //Get Entries

  Future<List<QuestionModel>> retrieveQuestions() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("questions").get();
    return snapshot.docs
        .map((docSnapshot) => QuestionModel.fromJson(docSnapshot))
        .toList();
  }
  Future<List<QuestionM>> getQuestions() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("questions").orderBy('id').get();
    return snapshot.docs
        .map((docSnapshot) => QuestionM.fromJson(docSnapshot))
        .toList();
  }
  // Future<List<Question>> getJobs() {
  //   return _db
  //       .collection('questions').get()
  //       .map((snapshot) =>
  //       snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  // }

  // get Single job
  // Stream<List<Jobs>> getsinglejob(String jobId) {
  //   return _db
  //       .collection('workerusers')
  //       .where('workerid', isEqualTo: jobId)
  //       .snapshots()
  //       .map((snapshot) =>
  //       snapshot.docs.map((doc) => Jobs.fromJson(doc.data())).toList());
  // }
}