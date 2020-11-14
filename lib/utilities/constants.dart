import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFf2f2f2),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

String websiteLink = "http://test.nilecrm.com";
String websiteApiLink = "http://test.nilecrm.com/api/v1/";

String websiteApiLocalLink = "http://10.0.2.2:8000/api/v1/";
