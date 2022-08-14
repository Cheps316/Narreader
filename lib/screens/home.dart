
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:narreader_app/controller/data_controller.dart';
import 'package:narreader_app/screens/drawer.dart';


import 'Screenpage.dart';
import 'add-product.dart';
import 'products_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
          title: Center(child: Text("Narreader"),),
          actions: [
            IconButton(onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: const Icon(Icons.search))
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
                            ),
                            
                            
                            )
                            )
                            )
                            ;

                   
                              
            },
          );
        }
        
         ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => AddProduct()),
  );
        },
        child: Icon(Icons.add),
        )
  );
}

}

// class View extends StatefulWidget {
//  final file;
//   View({this.file});

//   @override
//   State<View> createState() => _ViewState(
//     file
//   );
// }

// class _ViewState extends State<View> {
//   _ViewState(this.file);
//   final file;
  
//   bool isPlaying=false;
//   late FlutterTts _flutterTts;

//   @override
//   void initState(){
//     super.initState();
//     initializeTts();
//   }
//   initializeTts(){
//     _flutterTts = FlutterTts();

//     _flutterTts.setStartHandler(() {
//       setState(() {
//         isPlaying = true;
//       });
//     });

//     _flutterTts.setCompletionHandler(() {
//       setState(() {
//         isPlaying = false;
//       });
//     });

//     _flutterTts.setErrorHandler((err) {
//       setState(() {
//         print("error occurred: " + err);
//         isPlaying = false;
//       });
//     });

//   }
  
//   Widget build(BuildContext context) {
//      return Scaffold(appBar: AppBar(
//       title: Text("PDF",textAlign: TextAlign.center),

//     ),
//       body:
//       SfPdfViewer.network(
//       file,
//       pageLayoutMode:PdfPageLayoutMode.single,
//       ),
//       floatingActionButton: FloatingActionButton(
//       onPressed: _extractAllText ,
//       child: Icon(Icons.play_arrow), 
      
//     )
//     );   
//   }
//   Future<void> _extractAllText() async {
    
//     FilePickerResult? result =await FilePicker.platform. pickFiles ();
//     File pick = File(result!.files.single.path.toString());
//     var file = pick.readAsBytesSync();
    
//     //Load the existing PDF document.
//     PdfDocument document =
//         PdfDocument(inputBytes: file);
        

//     //Create the new instance of the PdfTextExtractor.
//     PdfTextExtractor extractor = PdfTextExtractor(document);

    
//     //Extract all the text from the document.
//     // String text = extractor.extractText();
//     String text = PdfTextExtractor(document).extractText(startPageIndex: 3, endPageIndex: 8);
//     //Display the text.
//     _showResult(text);
//   }

// void _showResult(String text) {
//   showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//           title: Text('Extracted text'),
//           content: Scrollbar(
//     child: SingleChildScrollView(
//     child: Text(text),
//     physics: BouncingScrollPhysics(
//     parent: AlwaysScrollableScrollPhysics()),
//     ),
//     ),
//     actions: [
//     FloatingActionButton.extended(
//     backgroundColor: Colors.blue,
//     label: Text('Close'),
//     onPressed: () {
//     Navigator.of(context).pop();
//     },
//     ),
//     FloatingActionButton(onPressed: (() {
//        if(isPlaying)
//         {
//           _stop();
//         }else
//         {
//           _speak(text);
//         }
//     })
//     ,child: isPlaying
//         ? Icon(
//              Icons.play_circle,
             
//               )
//         : Icon(
//              Icons.play_circle,
    
//             ),
//     )
//     ],
//     );
//     }

//     );
//   }
//   Future _speak(String text) async {
//     if (text.isNotEmpty) {
//       var result = await _flutterTts.speak(text);
//       if (result == 1)
//         setState(() {
//           isPlaying = true;
//         });
//     }
//   }

//   Future _stop() async {
//     var result = await _flutterTts.stop();
//     if (result == 1)
//       setState(() {
//         isPlaying = false;
//       });
//   }

//   void setTtsLanguage() async {
//     await _flutterTts.setLanguage("en-US");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _flutterTts.stop();
//   }
// }
