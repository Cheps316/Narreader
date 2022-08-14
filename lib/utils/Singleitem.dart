// import 'package:flutter/material.dart';

// class SingleItem extends StatelessWidget {
//   const SingleItem({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 90,
//                   child: Center(
//                     // child: Image.network(
//                       // widget.productImage,
//                     // ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 90,
//                   child: Column(
//                     mainAxisAlignment: widget.isBool == false
//                         ? MainAxisAlignment.spaceAround
//                         : MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.productName,
//                             style: TextStyle(
//                                 color: textColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                           Text(
//                             "${widget.productPrice}\$",
//                             style: TextStyle(
//                                 color: textColor, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       widget.isBool == false
//                           ? GestureDetector(
//                               onTap: () {
//                                 showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) {
//                                       return Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: <Widget>[
//                                           ListTile(
//                                             title: new Text('50 Gram'),
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                           ),
//                                           ListTile(
//                                             title: new Text('500 Gram'),
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                           ),
//                                           ListTile(
//                                             title: new Text('1 Kg'),
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(right: 15),
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 height: 35,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                        "50 Gram",
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                     Center(
//                                       child: Icon(
//                                         Icons.arrow_drop_down,
//                                         size: 20,
//                                         color: primaryColor,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : Text(widget.productUnit)
//                     ],
//                   ),))]))]);
//   }
// }