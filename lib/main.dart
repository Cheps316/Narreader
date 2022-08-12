import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:narreader_app/provider/bookmark_provider.dart';
import 'package:narreader_app/screens/products_categories.dart';
import 'package:narreader_app/screens/products_details.dart';
import 'package:provider/provider.dart';

import 'screens/login-screen.dart';


Future main() async {
 WidgetsFlutterBinding.ensureInitialized ();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<BookmarkProvider>(create: (context)=>BookmarkProvider(),)
      ],child:GetMaterialApp(
      title: 'Narreader',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        ProductsCategories.id :(context)=>  ProductsCategories(),
        ProductsDetailsPage.id:(context)=> ProductsDetailsPage()
      },
    home: LoginScreen(),
    ));
  }
}
