import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class RiderData {
  String name;
  String contactno;
  String address;
  String pincode;
  String accountno;
  String ifsc;
  List localities;
  String aadhar;
  String pancard;
  String dl;
  String bankcheque;
  String photo;

  RiderData({
    required this.name,
    required this.contactno,
    required this.address,
    required this.pincode,
    required this.accountno,
    required this.ifsc,
    required this.localities,
    required this.aadhar,
    required this.pancard,
    required this.dl,
    required this.bankcheque,
    required this.photo,
  });

  factory RiderData.fromJson(Map<String, dynamic> json) {
    return RiderData(
      name: json['name'],
      contactno: json['contactno'],
      address: json['address'],
      pincode: json['pincode'],
      accountno: json['accountno'],
      ifsc: json['ifsc'],
      localities: json['localities'],
      aadhar: json['aadhar'],
      pancard: json['pancard'],
      dl: json['dl'],
      bankcheque: json['bankcheque'],
      photo: json['photo'],
    );
  }

  // 'name': name,
  //     'contactno': contactno,
  //     'address': address,
  //     'pincode': pincode,
  //     'accountno': accountno,
  //     'ifsc': ifsc,
  //     'aadhar': aadhar,
  //     'pancard': pancard,
  //     'dl': dl,
  //     'bankcheque': bankcheque,
  //     'photo': photo,

  toJson() {
    return {
      'details': {
        'name': name,
        'contactno': contactno,
        'address': address,
        'pincode': pincode,
        'accountno': accountno,
        'ifsc': ifsc,
        'localities': localities
      },
      'uploads': {
        'aadhar': aadhar,
        'pancard': pancard,
        'dl': dl,
        'bankcheque': bankcheque,
        'photo': photo,
      }
    };
  }
}

final db = FirebaseFirestore.instance;

final docRef = db.collection('Rider');

var riderData = ({
  name,
  contactno,
  address,
  pincode,
  accountno,
  ifsc,
  localities,
  id,
  aadhar,
  pancard,
  dl,
  bankcheque,
  photo,
}) async {
  RiderData data = RiderData(
    name: name,
    contactno: contactno,
    address: address,
    pincode: pincode,
    accountno: accountno,
    ifsc: ifsc,
    localities: localities,
    aadhar: aadhar,
    pancard: pancard,
    dl: dl,
    bankcheque: bankcheque,
    photo: photo,
  );

  await docRef.add(data.toJson()).then(
        (value) => log("Rider registered successfullly"),
        onError: (e) => log("Errror registering rider: $e"),
      );
};
