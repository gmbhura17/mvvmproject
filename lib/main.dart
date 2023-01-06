import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvmproject/providers/AnimalProvider.dart';
import 'package:mvvmproject/providers/EmployeeProvider.dart';
import 'package:mvvmproject/providers/ProductProvider.dart';
import 'package:mvvmproject/views/Extra/GoogleAdsExample.dart';
import 'package:mvvmproject/views/Extra/GoogleMapExample.dart';
import 'package:mvvmproject/views/Extra/GoogleMapPractice.dart';
import 'package:mvvmproject/views/common/HomePage.dart';
import 'package:mvvmproject/views/sportson/TeamHomePage.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => AnimalProvider()),
        ChangeNotifierProvider(create: (context) => EmployeeProvider()),
       ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.adaminaTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.purple,
          ),
          home: TeamHomePage()
      ),
    );
  }
}