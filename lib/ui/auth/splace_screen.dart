import 'package:firebaseapp/firebase_services/splace_service.dart';
import 'package:flutter/material.dart';

class SplaceScreen extends  StatefulWidget{
  const SplaceScreen({super.key});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {

  @override
  void initState() {
     SplaceServices splaceServices = SplaceServices();
     splaceServices.isLogin(context);
     super.initState();
  }


  @override
  Widget build (BuildContext context) {
    return const Scaffold(
      body:Center(
          child:Text("Splace Screen",style: TextStyle(fontSize: 24, color: Colors.yellowAccent , fontWeight: FontWeight.bold),))
    );
  }
}