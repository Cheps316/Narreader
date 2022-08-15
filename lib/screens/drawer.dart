import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narreader_app/controller/data_controller.dart';
import 'package:narreader_app/model/user_model.dart';
import 'package:narreader_app/screens/category.dart';

import 'login-screen.dart';

class AppDrawer extends StatefulWidget {
 
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
 final DataController controller = Get.find();

 User? user = FirebaseAuth.instance.currentUser;
 UserModel loggedInUser = UserModel();

@override
void initState(){
 super.initState();
 FirebaseFirestore.instance
     .collection("users")
     .doc(user!.uid)
     .get()
     .then((value){
   this.loggedInUser=UserModel.fromMap(value.data());
   setState((){});
 });
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 220,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                       'User : ${loggedInUser.name}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                    ),    
                      Text(
                        'Email : ${loggedInUser.email}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: const Text('Categories'),
                onTap: () {
                Get.back();
                Get.to(()=> Categories());
                  
                },
              ),
             
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


