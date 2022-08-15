import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:narreader_app/model/product_model.dart';

class BookmarkProvider with ChangeNotifier{

void addBookmarkData({
String? bookmarkid,
String? bookmarkname,
String? bookmarkimage,
String? bookmarkpdf,
String? bookmarkaudio,
  }) async{
    await FirebaseFirestore.instance
    .collection("bookmark")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("yourbookmarks")
    .doc(bookmarkid)
    .set({
        "bookmarkid": bookmarkid,
        "bookmarkname": bookmarkname,
        "bookmarkimage": bookmarkimage,
        "bookmarkpdf": bookmarkpdf,
        "bookmarkaudio": bookmarkaudio,
        "bookmark": true,
    },)
    ;
  }

  List<Product> bookmark =[];
 void getFavorite()async{
  List<Product> newList=[];
 QuerySnapshot value =await FirebaseFirestore.instance
 .collection("bookmark")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("yourbookmarks")
    .get();
    value.docs.forEach((element) {
      Product product = Product(
        productname: element.get("bookmarkname"),
         productuploaddate: element.get("bookmarkuploaddate"),
          productimage: element.get("bookmarkimage"),
           productpdf: element.get("bookmarkpdf"),
            productdescription: element.get("bookmarkdescription"),
             productcategory: element.get("bookmarkcategory"),
             productaudio: element.get("bookmarkaudio"),
              productid: element.get("bookmarkid"),
              productuploader: element.get("bookmarkwrittenby")
              );
               newList.add(product);
    },);
    bookmark = newList;
    notifyListeners();
}
 List<Product> get getFavoriteList{
  return bookmark;
}
}

