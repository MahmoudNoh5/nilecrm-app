import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nilecrm/models/account.dart';
import 'package:nilecrm/models/visit.dart';
import 'package:nilecrm/utilities/constants.dart' as constants;


class Contact {

  int id;
  String name;
  String type;
  String territory;
  String brick;
  String classContact;
  String specialization;
  String picture;
  String tel;
  String lat;
  String long;
  String email;
  Account account;
  Visit visits;


  Contact({
    this.id, this.name, this.type, this.territory,this.brick ,this.classContact ,
    this.specialization, this.picture, this.tel, this.lat, this.long, this.email, this.account, this.visits});

  factory Contact.fromJson(Map<String, dynamic> map) {
    return Contact(
      id: map["id"],
      name: map["name"],
      type:  map["type"],
      territory:  map["territory"],
      brick:  map["brick"],
      classContact:  map["class"],
      specialization:  map["specialization"],
      picture:  map["picture"],
      tel:  map["tel"],
      lat:  map["lat"],
      long:  map["long"],
      email:  map["email"],
      account:  map["account"],
      visits:  map["visits"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "type": type,"territory": territory,"brick": brick,"classContact": classContact, "specialization": specialization,"picture": picture,"tel": tel,"lat": lat,"long": long,"email": email,"account": account,"visits": visits};
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, "type": $type,"territory": $territory,"brick": $brick ,"classContact": $classContact ,"specialization": $specialization,"picture": $picture,"tel": $tel,"lat": $lat,"long": $long,"email": $email,"account": $account,"visits": $visits}';
  }

}

List<Contact> contactsFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Contact>.from(data.map((contact) => Contact.fromJson(contact)));
}

Contact contactFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return Contact.fromJson(data);

}

String contactToJson(Contact data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


// get all contacts
Future<List<Contact>> getAll() async{
  final response = await http.get(constants.websiteApiLink+"contacts/");
  if (response.statusCode == 200) {
    return contactsFromJson(response.body);
  } else {
    return null;
  }
}


//get one contact by id
Future<Contact> get(contactId) async{
  final response = await http.get(constants.websiteApiLink+"contacts/"+contactId.toString());
  if (response.statusCode == 200) {
    return  contactFromJson(response.body);
  } else {
    return null;
  }
}


//get Feedbacks for  contact
Future<Contact> getFeedbacks(contactId) async{
  final response = await http.get(constants.websiteApiLink+"contacts/"+contactId.toString()+"/feedbacks");
  if (response.statusCode == 200) {
    return  contactFromJson(response.body);
  } else {
    return null;
  }
}


