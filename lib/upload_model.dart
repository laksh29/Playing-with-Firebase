import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Details {
  final String name;
  final String contactno;
  final String address;
  final String pincode;
  final String accountno;
  final String ifsc;

  Details({
    required this.name,
    required this.contactno,
    required this.address,
    required this.pincode,
    required this.accountno,
    required this.ifsc,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      name: json['name'],
      contactno: (json['contactno']),
      address: json['address'],
      pincode: json['pincode'],
      accountno: json['accountno'],
      ifsc: json['ifsc'],
    );
  }

  toJson() {
    return {
      'name': name,
      'contactno': contactno,
      'address': address,
      'pincode': pincode,
      'accountno': accountno,
      'ifsc': ifsc,
    };
  }
}

class Upload {
  final String aadhar;
  final String pancard;
  final String dl;
  final String bankcheque;
  final String photo;

  Upload({
    required this.aadhar,
    required this.pancard,
    required this.dl,
    required this.bankcheque,
    required this.photo,
  });

  factory Upload.fromJson(Map<String, dynamic> json) {
    return Upload(
      aadhar: json['aadhar'],
      pancard: (json['pancard']),
      dl: json['dl'],
      bankcheque: json['bankcheque'],
      photo: json['photo'],
    );
  }

  toJson() {
    return {
      'aadhar': aadhar,
      'pancard': pancard,
      'dl': dl,
      'bankcheque': bankcheque,
      'photo': photo,
    };
  }
}

// initiate firestore
final db = FirebaseFirestore.instance;

// details function
void details = ({
  name,
  contactno,
  address,
  pincode,
  accountno,
  ifsc,
}) async {
  final docRef = db.collection('Rider').doc();
  Details rider = Details(
    name: name,
    contactno: contactno,
    address: address,
    pincode: pincode,
    accountno: accountno,
    ifsc: ifsc,
  );

  // await db.collection("Rider").add(rider.toJson());

  await docRef.set(rider.toJson()).then(
      (value) => log("Rider added successfully"),
      onError: (e) => log("Error adding rider: $e"));
};

// upload function
void upload({
  aadhar,
  pancard,
  dl,
  bankcheque,
  photo,
}) async {
  final docRef = db.collection('Rider').doc();
  Upload rider = Upload(
    aadhar: aadhar,
    pancard: pancard,
    dl: dl,
    bankcheque: bankcheque,
    photo: photo,
  );
  await docRef.set(rider.toJson()).then(
      (value) => log("Rider verified successfully"),
      onError: (e) => log("Error verifying rider: $e"));
}
