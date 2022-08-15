import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narreader_app/screens/PDF.dart';
import 'package:narreader_app/screens/product_image_picker.dart';

import '../controller/data_controller.dart';
import '../model/categories.dart';
import 'Audio.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({ Key? key }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  DataController controller = Get.put(DataController());

  var _userImageFile;
  var _pdfFile;
  var _audioFile;
  var categoryC = TextEditingController();

   final _formKey = GlobalKey<FormState>();
   
  Map<String, dynamic> productData = {
    "p_name": "",
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "p_description":"",
    "p_category":"",
    "p_uploader":"",
    "p_productid":"",
  };
  
  void _pickedImage(File image) {
    _userImageFile = image;

    print("Image got $_userImageFile");
  }  
  void _pickedPDF(File url) {
    _pdfFile = url;

    print("we got $_pdfFile");
  }
  void _pickedaudio(File audio) {
    _audioFile = audio;

    print("we got $_audioFile");
  }

  addProduct() {
  if (_userImageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Image Required",
              style: TextStyle(fontSize: 18.0, color: Colors.red),
                 textAlign:TextAlign.center,
               ),
               )
               );
  }
   if (_pdfFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "File Required",
              style: TextStyle(fontSize: 18.0, color: Colors.red),
                 textAlign:TextAlign.center,
               ),
               )
               );
  }
  if (_audioFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Audio Required",
              style: TextStyle(fontSize: 18.0, color: Colors.red),
                 textAlign:TextAlign.center,
               ),
               )
               );
  }
     _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is valid ");
     
      print('Data for new product $productData');

      controller.addNewProduct(productData,_userImageFile, _pdfFile,_audioFile);
    }
 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Product'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),

                 SizedBox(         
                    child: TextFormField(
                      maxLines: 4,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Product Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product Description Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      productData['p_description'] = value!;
                    },
                ),
                
                  ),
                   SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Written By',
                  ),
                  
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Writer's name Required";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_uploader'] = value!;
                  },
                ),
 SizedBox(
                  height: 30,
                ),
                DropdownButtonFormField<String>(
                  validator: (v) {
                    if(v!.isEmpty){
                      return 'should not be empty';
                    }
                    return null;
                  }, 
                  hint: Text('Select Category'),
                  items: categories
                  .map((e) => DropdownMenuItem(value: e.name, child: Text(e.name),))
                  .toList(growable: false),
                  onChanged: (String? value) {  
                    setState(() {
                      categoryC.text = value!;
                      print(value);
                    }
                    );
                  },
                onSaved: (value) {
                      productData['p_category'] = value!;
                    }
                ),
                SizedBox(
                  height: 30,
                ),
                ProductImage(_pickedImage),
                    SizedBox(
                  height: 30,
                ),
                PDF(_pickedPDF),
                  SizedBox(
                  height: 20,
                ),
                Audio(_pickedaudio),
                 
                ElevatedButton(
                  onPressed: addProduct,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

