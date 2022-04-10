import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
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
class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
  View({this.url});


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("PDF"),
      
    ),
    body: SfPdfViewer.network(
      url,
      controller: _pdfViewerController, 
    )
    );
  }
}