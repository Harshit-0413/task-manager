class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isCompleted;
  final String userId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    required this.userId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
    return TaskModel(
      id: id,
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isCompleted: map['isCompleted'],
      userId: map['userId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }
}
