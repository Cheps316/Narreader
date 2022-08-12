import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narreader_app/controller/data_controller.dart';
import 'package:narreader_app/screens/bookmarks.dart';


class AppDrawer extends StatelessWidget {
 
 final DataController controller = Get.find();

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
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                       'User : ${controller.userProfileData['fullName']}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    FittedBox(
                      child: Text(
                        'Email : ${controller.userProfileData['email']}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Your Product'),
                onTap: () {
                Get.back();
                Get.to(()=> Bookmarks());
                  
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


