// import 'package:flutter/material.dart';
// import 'package:grow_simplee/fb_model.dart';

// import 'functions.dart';

// class ShowcaseList extends StatefulWidget {
//   const ShowcaseList({
//     super.key,
//     required this.showList,
//   });
//   final List<RiderData> showList;
//   @override
//   State<ShowcaseList> createState() => _ShowcaseListState();
// }

// class _ShowcaseListState extends State<ShowcaseList> {
//   @override
//   Widget build(BuildContext context) {
//     final List showList = widget.showList;
//     // print(showList);
//     print(lengthOfRider);
//     return ListView.builder(
//       itemCount: showList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Dismissible(
//           key: UniqueKey(),
//           secondaryBackground: const SecondBackground(),
//           background: const Background(),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             margin: const EdgeInsets.symmetric(
//               vertical: 10.0,
//               horizontal: 20.0,
//             ),
//             padding: const EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//               color: Colors.white,
//             ),
//             child: Text(
//               showList.elementAt(index),
//             ),
//           ),
//           onDismissed: (direction) {
//             try {
//               if (direction == DismissDirection.endToStart) {
//                 final snackBar1 = SnackBar(
//                   content:
//                       Text("You have selected ${showList.elementAt(index)}"),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar1);
//               } else if (direction == DismissDirection.startToEnd) {
//                 final snackBar2 = SnackBar(
//                   content:
//                       Text("you have deleted ${showList.elementAt(index)}"),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar2);
//               }
//             } on Exception catch (e) {
//               print(e);
//             }
//           },
//         );
//       },
//     );
//   }
// }
