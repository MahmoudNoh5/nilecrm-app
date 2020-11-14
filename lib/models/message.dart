import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nilecrm/utilities/constants.dart' as constants;


class Message {

  int id;
  String title;
  String fromUser;
  String fromUserPicture;
  String createdAt;
  String message;

  Message({
    this.id,this.title,  this.fromUser, this.fromUserPicture, this.createdAt, this.message});

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      id: map["id"],
      title:  map["title"],
      fromUser: map["from_user"],
      fromUserPicture:  map["from_user_picture"],
      createdAt:  map["created_at"],
      message:  map["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "fromUser": fromUser, "fromUserPicture": fromUserPicture, "createdAt": createdAt,"message": message};
  }

  @override
  String toString() {
    return 'Message{id: $id,"title": $title, fromUser: $fromUser, "fromUserPicture": $fromUserPicture,"createdAt": $createdAt,"message": $message}';
  }

}

List<Message> messagesFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Message>.from(data.map((message) => Message.fromJson(message)));
}

Message messageFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return Message.fromJson(data);

}

String messageToJson(Message data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


// get all messages
Future<List<Message>> getAll() async{
  final response = await http.get(constants.websiteApiLink+"messages/");
  if (response.statusCode == 200) {
    return messagesFromJson(response.body);
  } else {
    return null;
  }
}


//get one message by id
Future<Message> get(messageId) async{
  final response = await http.get(constants.websiteApiLink+"messages/"+messageId.toString());
  if (response.statusCode == 200) {
    return  messageFromJson(response.body);
  } else {
    return null;
  }
}


//replay message
Future<Message> replay(messageId, fromUserId, message ) async{

  final response = await http.post(
    constants.websiteApiLink+"messages/"+messageId.toString(),
    headers: {"content-type": "application/json"},
    body: jsonEncode(<String, String>{
      'message_id': messageId,
      'from_user_id': fromUserId,
      'message': message,
    }),
  );
  if (response.statusCode == 200) {
    return  messageFromJson(response.body);
  } else {
    return null;
  }
}
