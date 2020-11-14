import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nilecrm/utilities/constants.dart' as constants;


class Visit {

  int id;
  int secondUserId;
  int contactId;
  String contact;
  String contactPicture;
  String contactLat;
  String contactLong;
  String type;
  String territory;
  String brick;
  bool inLocation;
  String startDate;
  String endDate;
  String dueDate;
  String endLat;
  String endLong;
  String line;
  String address;
  String classVisit;
  String specialization;
  String startLong;
  String startLat;
  String feedback;
  String approvedAt;
  String createdAt;
  List product;
  List productMessage;
  int sample;
  int other;

  Visit({
    this.id,this.secondUserId, this.contactId, this.contact, this.contactPicture,this.contactLat ,this.contactLong ,
    this.type, this.territory, this.brick, this.inLocation,this.startDate ,this.endDate, this.dueDate, this.endLat, this.endLong,
    this.line, this.address, this.classVisit, this.specialization,this.startLong ,this.startLat, this.feedback,
    this.approvedAt, this.createdAt, this.product, this.productMessage, this.sample, this.other});


  factory Visit.fromJson(Map<String, dynamic> map) {
    return Visit(
      id: map["id"],
      secondUserId: map["second_user_id"],
      contactId: map["contact_Id"],
      contact: map["contact"],
      contactPicture: map["contact_picture"],
      contactLat: map["contact_lat"],
      contactLong: map["contact_long"],
      type: map["type"],
      territory: map["territory"],
      brick: map["brick"],
      inLocation: map["in_location"],
      startDate: map["start_date"],
      endDate: map["end_date"],
      dueDate: map["due_date"],
      endLat: map["end_lat"],
      endLong: map["end_long"],
      line: map["line"],
      address: map["address"],
      classVisit: map["class"],
      specialization: map["specialization"],
      startLong: map["start_long"],
      startLat: map["start_lat"],
      feedback: map["feedback"],
      approvedAt: map["approved_at"],
      createdAt: map["created_at"],
      product: map["product"],
      productMessage: map["product_message"],
      sample: map["sample"],
      other: map["other"],

    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id,"secondUserId": secondUserId, "contactId": contactId, "contact": contact,"contactPicture": contactPicture,"contactLat": contactLat,"contactLong": contactLong, "type": type,"territory": territory,"brick": brick,"inLocation": inLocation,"startDate": startDate,"endDate": endDate,"dueDate": dueDate,"endLat": endLat,"endLong": endLong,"line": line,"address": address,"classVisit": classVisit,"specialization": specialization,"startLong": startLong,"startLat":  startLat,"feedback": feedback,"createdAt": createdAt,"product": product,"productMessage": productMessage,"sample": sample,"sample": sample};
  }

  @override
  String toString() {
    return 'Visit{id: $id,secondUserId: $secondUserId, contactId: $contactId, "contact": $contact,"contactPicture": $contactPicture,"contactLat": $contactLat ,"contactLong": $contactLong ,"type": $type,"territory": $territory,"brick": $brick,"inLocation": $inLocation,"startDate": $startDate,"endDate": $endDate,"dueDate": $dueDate,"endLat": $endLat,"endLong": $endLong,"line": $line,"address": $address,"classVisit": $classVisit,"specialization": $specialization,"startLong": $startLong,"startLat": $startLat,"feedback": $feedback,"createdAt": $createdAt,"product": $product,"productMessage": $productMessage,"sample": $sample,"sample": $sample}';
  }

}

List<Visit> visitsFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Visit>.from(data.map((visit) => Visit.fromJson(visit)));
}

Visit visitFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return Visit.fromJson(data);

}

String visitToJson(Visit data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


// get all visits
Future<List<Visit>> getAll() async{
  final response = await http.get(constants.websiteApiLink+"visits/");
  if (response.statusCode == 200) {
    return visitsFromJson(response.body);
  } else {
    return null;
  }
}


//get one visit by id
Future<Visit> get(visitId, lat, lng) async{
  final response = await http.get(constants.websiteApiLink+"visits/"+visitId.toString()+"/"+lat.toString()+"/"+lng.toString());
  if (response.statusCode == 200) {
    return  visitFromJson(response.body);
  } else {
    return null;
  }
}


//sync visit
Future<Visit> sync(Visit visit) async{

  List visitRequest = [{
  'id': visit.id.toString(),
  'second_user_id': visit.secondUserId.toString(),
  'start_date': visit.startDate.toString(),
  'start_lat': visit.startLat.toString(),
  'start_long': visit.startLong.toString(),
  'end_date': visit.endDate.toString(),
  'end_lat': visit.endLat.toString(),
  'end_long': visit.endLong.toString(),
  'feedback': visit.feedback.toString(),
  'contact_id': visit.contactId.toString(),
  'product': visit.product.toString(),
  'product_message': visit.productMessage.toString(),
  'sample': visit.sample.toString(),
  'other': visit.other.toString(),
  }];

  // encryption => visitRequest
  var visitEncryption = '';

  final response = await http.post(
    constants.websiteApiLink+"visits/sync",
    headers: {"content-type": "application/json"},
    body: jsonEncode(<String, String>{
      'attribute': visitEncryption,
    }),
  );
  if (response.statusCode == 200) {
    return  visitFromJson(response.body);
  } else {
    return null;
  }
}
