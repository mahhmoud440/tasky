class TaskModel {
  final int id;
  final String taskName;
  final String desTask;
  final bool hghPriority;
  bool isDone;


  TaskModel({
    required this.id,
    required this.taskName,
    required this.desTask,
    required this.hghPriority,
     this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      taskName: json["taskName"],
      desTask: json["desTask"],
      hghPriority: json["hghPriority"],
      isDone: json["isDone"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "taskName": taskName,
      "desTask": desTask,
      "hghPriority": hghPriority,
      "isDone": isDone,
    };
  }

  @override
  String toString() {
    return "$id,taskName:$taskName,desTask:$desTask,hghPriority:$hghPriority,isDone:$isDone";
  }
}
