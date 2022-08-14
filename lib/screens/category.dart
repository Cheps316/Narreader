import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narreader_app/model/categories.dart';
import 'package:narreader_app/screens/products_categories.dart';

import '../controller/categories_slider.dart';
import '../controller/data_controller.dart';

class Categories extends StatelessWidget {
  
  final DataController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // controller.getLoginUserProduct();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: ListView(
        children: [
          CSlider(),
                        SizedBox(height: 20),
                        Text(
                          'CATEGORIES',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: 
                          categories.map((e) => Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pushNamed(ProductsCategories.id,
                              arguments: {
                                "category":e.name,
                       
                              }),
                              child: Container(
                                decoration:  BoxDecoration(
                                  gradient:LinearGradient(
                                  begin:Alignment.centerLeft,
                                  end:Alignment.centerRight,
                                  colors:[Colors.purple,Colors.blue]),
                                   ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text(e.name,style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )).toList())
                      
        ],
      )
      );  
  }

}