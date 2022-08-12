// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioFile extends StatefulWidget {
//   final AudioPlayer advancedPlayer;
//   const AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

//   @override
//   State<AudioFile> createState() => _AudioFileState();
// }

// class _AudioFileState extends State<AudioFile> {
//   Duration _duration =new Duration();
// Duration _position =new Duration();
                  
// bool isplaying=false;
// bool isPaused=false;
// bool isLoop=false;
// List<IconData>_icons=[
//   Icons.play_circle_fill,
//   Icons.pause_circle_filled,
// ];

//   @override
//   void initState(){
//     super.initState();
//     this.widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {
//       _duration=d;
//     }); });
//     // this.widget.advancedPlayer.onAudioPositionChanged.listen((p){setState(() {
//     //   _position=p;
//     // });});
   
//   }
//   Widget btnStart(){
//   // isplaying=bool;

//   return IconButton(
//       padding:const EdgeInsets.only(bottom:30),
//       icon: isplaying==false?Icon(_icons[0],size: 40, color: Colors.blue,):Icon(_icons[1], size: 40,color: Colors.blue),
//       onPressed:(){
//         if(isplaying == false){
//         this.widget.advancedPlayer.play();
//   setState((){
//    isplaying=true;
//  });
// }else if(isplaying == true){
//   setState((){
//    isplaying=false;
//  });
//       }
//   });
//   }
//    Widget btnFast(){
//   return
//     IconButton(
//      icon:Icon(Icons.skip_next,size:30),
//       onPressed:(){
//       this.widget.advancedPlayer!.setPlaybackRate(1.5);
//       },
//     );
//     }
//     Widget btnSlow(){
//   return
//     IconButton(
//      icon:Icon(Icons.skip_previous,size: 30,),
//       onPressed:(){
//       this.widget.advancedPlayer!.setPlaybackRate(0.5);
//       },
//     );
//     }
      
// Widget LoadAsset(){
//   return
//     Container(
//         child:Row(
//             crossAxisAlignment:CrossAxisAlignment.center,
//             mainAxisAlignment:MainAxisAlignment.spaceEvenly,
//             children:[
//             btnSlow(),
//              btnStart(),
//              btnFast()
//             ])// Row
//    );
//    }// Container

//    Widget slider() {
//     return Slider(
//         activeColor: Colors.red,
//         inactiveColor: Colors.grey,
//         value: _position.inSeconds.toDouble(),
//         min: 0.0,
//         max: _duration.inSeconds.toDouble(),
//         onChanged: (double value) {
//           setState(() {
//             changeToSecond(value.toInt());
//             value = value;
//           });});
//   }

//   void changeToSecond(int second){
//     Duration newDuration = Duration(seconds: second);
//     this.widget.advancedPlayer.seek(newDuration);
//   }
//  // IconButton// IconButton
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(padding: const EdgeInsets.only(left: 20,right: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//                 Text(_position.toString().split(".")[0], 
//                 style: TextStyle(fontSize: 16),),
            
//                 Text(_duration.toString().split(".")[0], 
//                 style: TextStyle(fontSize: 16),)
//             ],
//           ),),
//           slider(),
//           LoadAsset(),   
//         ],
//       ),
//     );
//   }

// }