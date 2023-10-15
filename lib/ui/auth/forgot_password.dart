import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/utils/utilities.dart';
import 'package:firebaseapp/widgets/roundedBtn.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title:Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",

              ),
              controller: emailController,
            ),
           const SizedBox(height: 30,),
           RoundedButton(title: "Reset Password",
               onTap: (){
                 firebaseAuth.sendPasswordResetEmail(email: emailController.text.toString()).
                 then((value){
                   Utils().ToastMessage("Succes");
                 }).onError((error, stackTrace) {
                   Utils().ToastMessage(error.toString());
                 });
               }
           )
          ],
        ),
      ),
    );
  }
}
