import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
   UserModel loggedInUser = UserModel();

   

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  
  }

  String url='';
  int? number;

  uploadDataToFirebase() async{
      
    // //genrate random number
    //   number= Random ().nextInt(10);
      //pick pdf file
    FilePickerResult? result =await FilePicker.platform. pickFiles ();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync ();
    String name = DateTime.now ().millisecondsSinceEpoch. toString();

    //uptoading file to firebasse
    var pdfFile = FirebaseStorage.instance.ref().child(name);
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    
    //upload url to cloud firebase
    await FirebaseFirestore.instance.collection("file").doc().set({
      'fileUrl':url,
      'num':"Book"
      // +number.toString()
});
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Auth User (Logged ' + (user == null ? 'out' : 'in') + ')'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection ("file").snapshots(),
          builder: (context, AsyncSnapshot <QuerySnapshot>snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount:snapshot.data!.docs.length,
                itemBuilder:  (context, i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
    
                  return InkWell(
                    onTap: (){
                      print("fileurl -> $x");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> View(url: x['fileUrl'],)));
                      },
                    child: Container(
                      margin:  EdgeInsets.symmetric(vertical:  10),
                      child: Text(x["num"]),
                    ),
                  );
          }
          );
          }
          return Center(child:  CircularProgressIndicator(),);
        
        }
        ),

        floatingActionButton: FloatingActionButton(onPressed: uploadDataToFirebase,
        child: Icon(Icons.add),)
  );
}
}

class View extends StatefulWidget {
 final url;
  View({this.url});

  @override
  State<View> createState() => _ViewState(
    url
  );
}

class _ViewState extends State<View> {
  _ViewState(this.url);
  final url;
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("PDF"),
    ),
      body: 
      SfPdfViewer.network(
      url,
      pageLayoutMode:PdfPageLayoutMode.single,
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: _extractAllText ,
      child: Icon(Icons.play_arrow), 
      
    )
    );
    
  }
  Future<void> _extractAllText() async {
    
    FilePickerResult? result =await FilePicker.platform. pickFiles ();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync ();
    
    //Load the existing PDF document.
    PdfDocument document =
        PdfDocument(inputBytes: file);

    //Create the new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

    
    //Extract all the text from the document.
    String text = extractor.extractText();

    //Display the text.
    _showResult(text);
  }

void _showResult(String text) {
  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
          title: Text('Extracted text'),
          content: Scrollbar(
    child: SingleChildScrollView(
    child: Text(text),
    physics: BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics()),
    ),
    ),
    actions: [
    FloatingActionButton(
    child: Text('Close'),
    onPressed: () {
    Navigator.of(context).pop();
    },
    )
    ],
    );
    }

    );
  }
}

 