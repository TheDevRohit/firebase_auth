import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/Home/home_page.dart';
import 'package:flutter/material.dart';
import '../ui/auth/login_screen.dart';

class SplaceServices {

  void  isLogin(BuildContext context){

    FirebaseAuth auth = FirebaseAuth.instance;

    if(auth.currentUser != null){
      Timer(const Duration(seconds: 3) ,() {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage()));
       });
      }else{
        Timer(const Duration(seconds: 3) ,() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      });
    }
  }
}