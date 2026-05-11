import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'tasks';

  Stream<List<TaskModel>> getTasks(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addTask(TaskModel task) async {
    await _firestore.collection(_collection).add(task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    await _firestore.collection(_collection).doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection(_collection).doc(taskId).delete();
  }

  Future<void> toggleComplete(TaskModel task) async {
    await _firestore.collection(_collection).doc(task.id).update({
      'isCompleted': !task.isCompleted,
    });
  }
}
