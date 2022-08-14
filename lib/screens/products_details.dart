import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:narreader_app/provider/bookmark_provider.dart';
import 'package:provider/provider.dart';

import 'View.dart';
class ProductsDetailsPage extends StatefulWidget {
 static const id ='productsdetail';

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  // var isFavorite;

 getFavorite(){
    FirebaseFirestore.instance
    .collection("bookmark")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("yourbookmarks")
    .get()
    .then((value) => {
      value.docs.forEach((element) {
        if(this.mounted){
          setState(() => {
            // isFavorite= element.get("bookmark")
          },);
        }
      })
    }
     );
  }
  @override
  Widget build(BuildContext context) {
     BookmarkProvider bookmarkProvider = Provider.of(context);
    final data = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    var name = data['productname'];
    var image = data['productimage'];
    var pdf = data['productpdf'];
    var description = data['productdescription'];
    var audio = data['productaudio'];
    var writtenby=data['productwrittenby'];
    var productid=data['productid'];

    return Scaffold(
       appBar: AppBar(
        elevation: 0.0,
        title: Text(name),
        actions: [
          FavoriteButton(iconSize: 40,
          isFavorite: false,
                                valueChanged: (_isFavorite) {
                                  if(_isFavorite== true){
                                    bookmarkProvider.addBookmarkData(
                                      bookmarkid: productid,
                                      bookmarkname: name,
                                      bookmarkimage: image,
                                      bookmarkpdf: pdf,
                                      bookmarkaudio: audio,
                                      );                                  
                                  }
                                },)
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: double.infinity,
                child:
              Image.network(image,fit: BoxFit.fill
              ),
              ),
              Container( 
                decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: Offset(3, 3),
                  ),],),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                       Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              
              Container(
                width: double.infinity,
                height: 250,
                
               decoration: BoxDecoration(
                color:  Colors.grey.withOpacity(0.2)
               ), 
               child: Column(
                 children: [
                  Row(
                    children: [
                      Text("Written by : " +writtenby,style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    ],
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       children: [
                         Text(description,style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                       ],
                     ),
                   ),
                 ],
               ),
              )
            
                    ],
                  ),
                ),
              ),
              
              MaterialButton(
                minWidth: double.infinity,
                onPressed: (() {
                Navigator.push(context, 
                MaterialPageRoute(builder: ((context) => View(file: pdf,fileaudio:audio))));
              }),
              child: Text("Read"),
                color: Colors.blue),
              //    MaterialButton(
              //   minWidth: double.infinity,
              //   onPressed: (() {
              //   Navigator.push(context, 
              //   MaterialPageRoute(builder: ((context) => (file: pdf,fileaudio:audio))));
              // }),
              // child: Text("Listen"),
              //   color: Colors.blue),
            ],
          ),
        ),
 
    );
  }
  
  }