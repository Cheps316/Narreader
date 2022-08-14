
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:narreader_app/screens/audio_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class View extends StatefulWidget {
  final file;
  final fileaudio;
 
  View({this.file,this.fileaudio});

  @override
  State<View> createState() => _ViewState(file,fileaudio);
}

class _ViewState extends State<View> {


  _ViewState(this.file,this.fileaudio);
  final file;
  final fileaudio;

  late AudioPlayer advancedPlayer;

  @override
 
  void initState(){
    super.initState();
    advancedPlayer = AudioPlayer();
  }
  Widget build(BuildContext context) {

final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(appBar: AppBar(
      title: Text("pdf",textAlign: TextAlign.center),

    ),
      body:
      Stack(
        children: [
          Positioned(
          child: 
          SfPdfViewer.network(
          file,
          pageLayoutMode:PdfPageLayoutMode.single,
          ),
        ),
     
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 200,
    
            width: screenWidth,
             decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
          ),
            child:AudioFile(advancedPlayer: advancedPlayer,audiopath:fileaudio)
            ),
        )
        ],
      ),
    );   
  }
}