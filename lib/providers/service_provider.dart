import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/models/todoservice_modle.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final getData = FirebaseFirestore.instance
        .collection(user.uid)
        .orderBy('isStar', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((snapshot) => TodoModel.fromSnapshot(snapshot))
            .toList());
    yield* getData;
  }
});

//Refreshing the StreamProvider when switching accounts
final fetchStreamProviderWrapper =
    FutureProvider.autoDispose<void>((ref) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // ignore: unused_result
    ref.refresh(fetchStreamProvider);
  }
});
