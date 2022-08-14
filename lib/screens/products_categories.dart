
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:narreader_app/screens/products_details.dart';


class ProductsCategories extends StatefulWidget {

  static const id = "/products_categories";

  @override
  State<ProductsCategories> createState() => _ProductsCategoriesState();
}

class _ProductsCategoriesState extends State<ProductsCategories> {
  
   FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var category = data["category"];
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(category),
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: db.collection('productlist')
        .where("product_category",isEqualTo: category)
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
                               "productwrittenby": values[index]['product_writtenby'],
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
        
         )
    );
  }
}