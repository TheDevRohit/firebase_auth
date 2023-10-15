import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/utils/utilities.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Home Screen"),

          actions: [
            IconButton(
                onPressed: (){
               firebaseAuth.signOut().then((value) => {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen())),
                 Utils().ToastMessage("Log Out Successfully"),
               }).onError((error, stackTrace) => {
                 Utils().ToastMessage(error.toString()),
               });
            }, icon: const Icon(Icons.logout))
          ],
        ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Current Use Uid : ${firebaseAuth.currentUser!.uid}"),
            const SizedBox(height: 10,),
            Text("Current User Email : ${firebaseAuth.currentUser!.email.toString()}"),
            const SizedBox(height: 10,),
          ],
        ),
      ),
     );
  }
}
