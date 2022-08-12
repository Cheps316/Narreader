import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Audio extends StatefulWidget {
  final void Function(File pickedaudio) getaudiovalue;
  Audio(this.getaudiovalue);

  @override
  State<Audio> createState() => _AudioState();
}

  
class _AudioState extends State<Audio> {
File? fileaudio;

  uploadDataToFirebase(FilePicker audioType) async{

    final resultaudio = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.audio);
    if(resultaudio == null) return;
    final pathaudio = resultaudio.files.single.path!;
    setState(() =>
    fileaudio = File(pathaudio));
    
    widget.getaudiovalue(fileaudio!);
   
  }
  @override
  Widget build(BuildContext context) {
    final audiofile = fileaudio!= null ? basename(fileaudio!.path):  "No File Selected";
   return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 100,
          child: SizedBox(child: Text(audiofile, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),))
        ),
        ElevatedButton.icon(
          onPressed: ()=>uploadDataToFirebase(FilePicker.platform),
          icon: Icon(Icons.file_copy),
          label: Text('Add Audio'),
        ),
      ],
    );
}
}
