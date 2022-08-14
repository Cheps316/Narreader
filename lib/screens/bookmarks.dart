
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:narreader_app/controller/data_controller.dart';
import 'package:narreader_app/screens/drawer.dart';

import 'products_details.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {

  final DataController controller = Get.put(DataController());
   FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllProduct();
    });
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
          title: Text("Home Page"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search))
          ],
        ),
      
        
        body: 
StreamBuilder(
        stream: db.collection('productlist')
        .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: "error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final values = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
     Navigator.of(context).pushNamed(ProductsDetailsPage.id,
                              arguments: {
                               "productname": values[index]['product_name'],
                               "productcategory": values[index]['product_category'],
                               "productimage": values[index]['product_image'],
                               "productpdf": values[index]['product_pdf'],
                               "productdescription": values[index]['product_description'],
                               "productupload": values[index]['product_upload_date'],
                               "productaudio": values[index]['product_audio'],
                               "productid":values[index]["product_id"],
                               "productwrittenby":values[index]["product_writtenby"]
                        },);},
             child: Container(
                        
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),

                                   child: Image.network(
                                  values[index]['product_image'],  
                                  fit: BoxFit.cover,   
                                  height: 300,
                                  width: 200,                        
                                )),
                                            
                              Positioned(
                        
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child:
                                              Text(values[index]['product_name'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  )),
                                        ),
 
                            ]
                            )
                            )
                            )
                            )
                            ]
                            )
                            )
                            )
                            )
                            ;

                   
                              
            },
          );
        }
        
         ),
  );
}

}


