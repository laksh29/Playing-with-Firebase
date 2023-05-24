import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class RiderData {
  String? name;
  String? contactno;
  String? address;
  String? pincode;
  String? accountno;
  String? ifsc;
  List? localities;
  String? aadhar;
  String? pancard;
  String? dl;
  String? bankcheque;
  String? photo;

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

  factory RiderData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RiderData(
      name: data['name'],
      contactno: data['contactno'],
      address: data['address'],
      pincode: data['pincode'],
      accountno: data['accountno'],
      ifsc: data['ifsc'],
      localities: data['localities'],
      aadhar: data['aadhar'],
      pancard: data['pancard'],
      dl: data['dl'],
      bankcheque: data['bankcheque'],
      photo: data['photo'],
    );
  }

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

List<RiderData> allRiderData = [];
int lengthOfRider = 0;

// Future<List<RiderData>> getAllRiders() async {
//   var snapshot = await docRef.get();
//   var riderData = snapshot.docs.map((e) => RiderData.fromSnapshot(e)).toList();
//   // allRiderData = riderData;
//   // print(allRiderData);
//   return riderData;
// }

// Stream<List<RiderData>> getAllRiders() => FirebaseFirestore.instance
//     .collection("Rider")
//     .snapshots()
//     .map((event) => event.docs
//         .map(
//           (e) => RiderData.fromJson(e.data()),
//         )
//         .toList());

Future readRider(String docId) async {
  final docRef = FirebaseFirestore.instance.collection("Rider").doc(docId);
  final snapshot = await docRef.get();

  if (snapshot.exists) {
    return snapshot.data();
  }
}
