import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nilecrm/utilities/constants.dart' as constants;


class Notification {

  int id;
  String title;
  String fromUser;
  String fromUserPicture;
  String createdAt;
  String notification;

  Notification({
    this.id,this.title,  this.fromUser, this.fromUserPicture, this.createdAt, this.notification});

  factory Notification.fromJson(Map<String, dynamic> map) {
    return Notification(
      id: map["id"],
      title:  map["title"],
      fromUser: map["from_user"],
      fromUserPicture:  map["from_user_picture"],
      createdAt:  map["created_at"],
      notification:  map["notification"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "fromUser": fromUser, "fromUserPicture": fromUserPicture, "createdAt": createdAt,"notification": notification};
  }

  @override
  String toString() {
    return 'Notification{id: $id,"title": $title, fromUser: $fromUser, "fromUserPicture": $fromUserPicture,"createdAt": $createdAt,"notification": $notification}';
  }

}

List<Notification> notificationsFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Notification>.from(data.map((notification) => Notification.fromJson(notification)));
}

Notification notificationFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return Notification.fromJson(data);

}

String notificationToJson(Notification data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


// get all notifications
Future<List<Notification>> getAll() async{
  final response = await http.get(constants.websiteApiLink+"notifications/");
  if (response.statusCode == 200) {
    return notificationsFromJson(response.body);
  } else {
    return null;
  }
}


//get one notification by id
Future<Notification> get(notificationId) async{
  final response = await http.get(constants.websiteApiLink+"notifications/"+notificationId.toString());
  if (response.statusCode == 200) {
    return  notificationFromJson(response.body);
  } else {
    return null;
  }
}


//create notification
Future<Notification> create( title, notification ) async{

  final response = await http.post(
    constants.websiteApiLink+"notifications/create",
    headers: {"content-type": "application/json"},
    body: jsonEncode(<String, String>{
      'title': title,
      'notification': notification,
    }),
  );
  if (response.statusCode == 200) {
    return  notificationFromJson(response.body);
  } else {
    return null;
  }
}
