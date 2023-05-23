import 'package:flutter/material.dart';

// list tile swipe bg
class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 25.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.red,
      child: const Icon(Icons.delete),
    );
  }
}

// list tile swipe bg
class SecondBackground extends StatelessWidget {
  const SecondBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 25.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.green,
      child: const Icon(Icons.golf_course),
    );
  }
}

// dropdown menu
// class DropDownMenu extends StatefulWidget {
//   final Function(List<String>) selectedList;
//   final List<String> listOFStrings;

//   const DropDownMenu({
//     required this.selectedList,
//     required this.listOFStrings,
//     super.key,
//   });

//   @override
//   createState() {
//     return _DropDownMenuState();
//   }
// }

// class _DropDownMenuState extends State<DropDownMenu> {
//   List<String> listOFSelectedItem = [];
//   String selectedText = "";

//   @override
//   Widget build(BuildContext context) {
//     // var size = MediaQuery.of(context).size;
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(10)),
//       child: ExpansionTile(
//         iconColor: Colors.black,
//         title: Text(
//           listOFSelectedItem.isEmpty
//               ? "Select 3 Localities"
//               : listOFSelectedItem.length == 1
//                   ? listOFSelectedItem[0]
//                   : listOFSelectedItem.length == 2
//                       ? "${listOFSelectedItem[0]}, ${listOFSelectedItem[1]}"
//                       : "${listOFSelectedItem[0]}, ${listOFSelectedItem[1]}, ${listOFSelectedItem[2]}",
//           style: TextStyle(
//             color: Colors.grey[700],
//             fontWeight: FontWeight.w400,
//             fontSize: 15.0,
//           ),
//         ),
//         children: <Widget>[
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.listOFStrings.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8.0),
//                 child: ViewItem(
//                     item: widget.listOFStrings[index],
//                     selected: (val) {
//                       selectedText = val;
//                       if (listOFSelectedItem.contains(val)) {
//                         listOFSelectedItem.remove(val);
//                       } else {
//                         listOFSelectedItem.add(val);
//                       }
//                       widget.selectedList(listOFSelectedItem);
//                       setState(() {});
//                     },
//                     itemSelected: listOFSelectedItem
//                         .contains(widget.listOFStrings[index])),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class ViewItem extends StatelessWidget {
  final String item;
  final bool itemSelected;
  final Function(String) selected;
  final Function(String) deselected;

  final bool three;

  const ViewItem({
    required this.item,
    required this.itemSelected,
    required this.selected,
    required this.deselected,
    required this.three,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * .032, right: size.width * .098),
      child: Row(
        children: [
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: itemSelected,
              onChanged: (val) {
                three ? deselected(item) : selected(item);
              },
              activeColor: Colors.blue,
            ),
          ),
          SizedBox(
            width: size.width * .025,
          ),
          Text(
            item,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
