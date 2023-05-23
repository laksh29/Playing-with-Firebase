import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Details {
  String name;
  String contactno;
  String address;
  String pincode;
  String accountno;
  String ifsc;
  // String aadhar;
  // String pancard;
  // String dl;
  // String bankcheque;
  // String photo;

  Details({
    required this.name,
    required this.contactno,
    required this.address,
    required this.pincode,
    required this.accountno,
    required this.ifsc,
    // required this.aadhar,
    // required this.pancard,
    // required this.dl,
    // required this.bankcheque,
    // required this.photo,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      name: json['name'],
      contactno: json['contactno'],
      address: json['address'],
      pincode: json['pincode'],
      accountno: json['accountno'],
      ifsc: json['ifsc'],
      // aadhar: json['aadhar'],
      // pancard: json['pancard'],
      // dl: json['dl'],
      // bankcheque: json['bankcheque'],
      // photo: json['photo'],
    );
  }

  // factory Details.fromJson(Map<String, dynamic> json) {
  //   return Details(
  //     name: json['name'],
  //     contactno: (json['contactno']),
  //     address: json['address'],
  //     pincode: json['pincode'],
  //     accountno: json['accountno'],
  //     ifsc: json['ifsc'],
  //   );
  // }

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
// var uuid = const Uuid();
final docRef = db.collection('Rider');
// details function
var riderDetails = ({
  name,
  contactno,
  address,
  pincode,
  accountno,
  ifsc,
  id,
  aadhar,
  pancard,
  dl,
  bankcheque,
  photo,
}) async {
  Details riderDetails = Details(
    name: name,
    contactno: contactno,
    address: address,
    pincode: pincode,
    accountno: accountno,
    ifsc: ifsc,
  );



  // await db.collection("Rider").add(rider.toJson());

  await docRef.add(riderDetails.toJson());
};

// upload function
var riderUpload = ({
  aadhar,
  pancard,
  dl,
  bankcheque,
  photo,
  id,
}) async {
  Upload riderUpload = Upload(
    aadhar: aadhar,
    pancard: pancard,
    dl: dl,
    bankcheque: bankcheque,
    photo: photo,
  );

  await docRef.add(riderUpload.toJson()).then(
      (value) => log("Rider verified successfully"),
      onError: (e) => log("Error verifying rider: $e"));
};
