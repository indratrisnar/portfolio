import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/page/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDIRbnmiPvcoVHTIN89nCop9UcBELPgC-4",
        authDomain: "portfolio-eae02.firebaseapp.com",
        projectId: "portfolio-eae02",
        storageBucket: "portfolio-eae02.appspot.com",
        messagingSenderId: "1078184886809",
        appId: "1:1078184886809:web:36f16d90b1c52d50132088",
        measurementId: "G-MCSFYG0XNG"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
