import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nilecrm/utilities/constants.dart' as constants;


class Task {

  int id;
  String fromUser;
  String fromUserPicture;
  String title;
  String dueDate;
  String completedAt;
  String createdAt;
  String description;
  String feedback;

  Task({
    this.id, this.fromUser, this.fromUserPicture, this.title,this.dueDate ,this.completedAt ,
    this.createdAt, this.description, this.feedback});

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      fromUser: map["from_user"],
      fromUserPicture:  map["from_user_picture"],
      title:  map["title"],
      dueDate:  map["due_date"],
      completedAt:  map["completed_at"],
      createdAt:  map["created_at"],
      description:  map["description"],
      feedback:  map["feedback"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "fromUser": fromUser, "fromUserPicture": fromUserPicture,"title": title,"dueDate": dueDate,"completedAt": completedAt,
      "createdAt": createdAt,"description": description,"feedback": feedback};
  }

  @override
  String toString() {
    return 'Task{id: $id, fromUser: $fromUser, "fromUserPicture": $fromUserPicture,"title": $title,"dueDate": $dueDate ,"completedAt": $completedAt ,"createdAt": $createdAt,"description": $description,"feedback": $feedback}';
  }

}

List<Task> tasksFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Task>.from(data.map((task) => Task.fromJson(task)));
}

Task taskFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return Task.fromJson(data);

}

String taskToJson(Task data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


// get all tasks
Future<List<Task>> getAll() async{
  final response = await http.get(constants.websiteApiLink+"tasks/");
  if (response.statusCode == 200) {
    return tasksFromJson(response.body);
  } else {
    return null;
  }
}


//get one task by id
Future<Task> get(taskId) async{
  final response = await http.get(constants.websiteApiLink+"tasks/"+taskId.toString());
  if (response.statusCode == 200) {
    return  taskFromJson(response.body);
  } else {
    return null;
  }
}


//update task
Future<Task> update(taskId, feedback) async{
  final response = await http.post(
    constants.websiteApiLink+"tasks/"+taskId.toString(),
    headers: {"content-type": "application/json"},
    body: jsonEncode(<String, String>{
      'feedback': feedback,
    }),
  );
  if (response.statusCode == 200) {
    return  taskFromJson(response.body);
  } else {
    return null;
  }
}
