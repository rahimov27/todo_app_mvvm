class TodoModel {
  String name;
  bool isFinished;
  DateTime date;
  String status;

  TodoModel({
    required this.name,
    required this.isFinished,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isFinished': isFinished,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      name: json['name'],
      isFinished: json['isFinished'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}
