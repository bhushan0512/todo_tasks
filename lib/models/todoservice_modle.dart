import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/todo_model.dart';

class TodoService {
  var todoCollection = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid.toString());

  //CREATE
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //UPDATE
  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

  void updateStarTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      'isStar': valueUpdate,
    });
  }

  void updateTaskDetails(
      String? docID, String? title, String? description, String? category) {
    todoCollection.doc(docID).update({
      'titleTask': title,
      'description': description,
      'category': category,
    });
  }

  //DELETE
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
