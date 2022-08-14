import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:narreader_app/screens/products_details.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, dynamic>? userMap;

  bool isLoading = false;

  final TextEditingController _search = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // const SearchPage({Key? key}) : super(key: key);
    void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('productlist')
        .where("product_name", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        if (value.docs.length < 1) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No Book Found")));
          isLoading = false;
        } else {
          userMap = value.docs[0].data();
          print(userMap);
          isLoading = false;
        }
      });

      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: _search,
            decoration: InputDecoration(
                
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {onSearch();
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
      body: Column(
              children: [       
                userMap != null
                    ? ListTile(
                      onTap: () {
     Navigator.of(context).pushNamed(ProductsDetailsPage.id,
                              arguments: {
                               "productname": userMap!['product_name'],
                               "productcategory": userMap!['product_category'],
                               "productimage": userMap!['product_image'],
                               "productpdf": userMap!['product_pdf'],
                               "productdescription": userMap!['product_description'],
                               "productupload": userMap!['product_upload_date'],
                               "productaudio": userMap!['product_audio'],
                               "productid":userMap!["product_id"],
                               "productwrittenby":userMap!["product_writtenby"]
                        },);},
                        leading: Icon(Icons.book_online, color: Colors.black),
                        title: Text(
                          userMap!['product_name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap!['product_writtenby']),
                      )
                    : Container(),
              ],
            ),
    );
  }
}

