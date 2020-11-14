import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nilecrm/models/visit.dart';
import 'package:nilecrm/utilities/constants.dart' as constants;


class Account {

  int id;
  String name;
  String address;
  String phone;
  String mobile;
  String fax;
  String webSite;
  String notes;
  String active;
  String type;
  String line;
  String territory;
  String brick;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Account({
    this.id, this.name, this.type, this.territory,this.brick ,this.address ,
    this.phone, this.mobile, this.fax, this.webSite, this.notes, this.active, this.line, this.createdAt, this.updatedAt, this.deletedAt});

  factory Account.fromJson(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      type:  map["type"],
      territory:  map["territory"],
      brick:  map["brick"],
      address:  map["address"],
      phone:  map["phone"],
      mobile:  map["mobile"],
      fax:  map["fax"],
      webSite:  map["web_site"],
      notes:  map["notes"],
      active:  map["active"],
      line:  map["line"],
      createdAt:  map["created_at"],
      updatedAt:  map["updated_at"],
      deletedAt:  map["deleted_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "type": type,"territory": territory,"brick": brick,"address;": address, "phone": phone,"mobile": mobile,"fax": fax,"notes": notes,"active": active,"active": active,"createdAt": createdAt,"createdAt": createdAt,"createdAt": createdAt};
  }

  @override
  String toString() {
    return 'Account{id: $id, name: $name, "type": $type,"territory": $territory,"brick": $brick ,"address;": $address ,"phone": $phone,"mobile": $mobile,"mobile": $notes,"notes": $active,"active": $active"createdAt": $createdAt,"createdAt": $createdAt,"createdAt": $createdAt}';
  }

}

List<Account> accountsFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Account>.from(data.map((account) => Account.fromJson(account)));
}

Account accountFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return Account.fromJson(data);

}

String accountToJson(Account data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


