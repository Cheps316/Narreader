
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:narreader_app/model/user_model.dart';

import '../model/product_model.dart';
import 'comman_dialog.dart';


class DataController extends GetxController {

  var productid ;
  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'fullName': '', 'email': ''};

  List<Product> allProduct =[];
   
  UserModel userModel =UserModel();

  void onReady() {
    super.onReady();
    getAllProduct();
    getUserProfileData();
  }

// Method for get User profile

Future<void> getUserProfileData() async {
    try {
      var response = await firebaseInstance
          .collection('users')
          .where('uid', isEqualTo: userModel.uid)
          .get();
      response.docs.forEach((response) {
        print(response.data());
      });
      if (response.docs.length > 0) {
        userProfileData['fullName'] = response.docs[2]['fullName'];
        userProfileData['email'] = response.docs[0]['email'];
      }
      print(userProfileData);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  //uploading products in firebase
Future<void> addNewProduct(Map productdata, File image, File url, File audio) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);

    final ref = FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();

    print(result);
 
    var pathpdf = url.toString();
    var temper = pathpdf.lastIndexOf('/');
    var res = pathpdf.substring(temper + 1);

    print(res);
   
    final refer = FirebaseStorage.instance.ref().child('product_pdf').child(res);
    var pdfFile =await refer.putFile(url);
    print("Updated $pdfFile");
    var pickedurl = await refer.getDownloadURL();

    var pathaudio = audio.toString();
    var temperorary = pathaudio.lastIndexOf('/');
    var resource = pathaudio.substring(temperorary + 1);

    print(resource);
   
    final reference = FirebaseStorage.instance.ref().child('product_audio').child(resource);
    var pdfAudio =await reference.putFile(audio);
    print("Updated $pdfAudio");
    var pickedaudio = await reference.getDownloadURL();
    
    try {
      CommanDialog.showLoading();
      var response = await FirebaseFirestore.instance.collection('productlist')
      .add({
        'product_name': productdata['p_name'],
        "product_upload_date": productdata['p_upload_date'],
        "product_description":productdata['p_description'],
        "product_category": productdata['p_category'],
        'product_image': imageUrl,
        'product_pdf': pickedurl,
        'product_audio': pickedaudio,
        "product_id":productid,
      });  
      productid =response.id;
      print(productid);
      CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


Future<void> getAllProduct() async {

    allProduct = [];
        print("allProduct YEs $allProduct");
    try {
      CommanDialog.showLoading();
      final List<Product> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('productlist')
          .get();
          
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            lodadedProduct.add(
              Product(
                 productpdf: result['product_pdf'],
                  productname: result['product_name'],
                  productimage: result['product_image'],
                  productuploaddate: result['product_upload_date'].toString(), 
                  productdescription: result['product_description'],
                  productcategory: result['product_category'],
                  productaudio: result['product_audio'],
                  productid:result['product_id'],
              ),
            );
          },
        );
      }
      allProduct.addAll(lodadedProduct);
      update();
      CommanDialog.hideLoading();
      
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

}