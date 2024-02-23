import 'package:chatapp/model/Account.dart';
import 'package:chatapp/view/NavBar/Navbar.dart';
import 'package:chatapp/view/chatPage/chatPage.dart';
import 'package:chatapp/view/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase_options.dart';
bool sginedIn = false ;  

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //   await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //   appleProvider: AppleProvider.appAttest,
  // );

  await Hive.initFlutter();
  await Hive.openBox("account"); 
   var box = Hive.box('account');
  if(box.get('user') != null) {
    Map acc = box.get('user');
    Account().email =acc["email"]; 
    Account().accountID =  acc["id"]; 
    Account().fullName =acc["name"] ; 
    Account().password = acc["password"]; 
    sginedIn =true ; 
  }
//   var box = Hive.box('account');
// box.put('name', {"email":"yassneyoussefwx","jdw":"dwadwa"});
// var name = box.get('user');
//  print('Name: $name');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        body:  sginedIn ?  NavBar():  Login () , 
        // NavBar(),
      ) 
    );
  }
}