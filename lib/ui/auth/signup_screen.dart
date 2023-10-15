import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/login_screen.dart';
import 'package:firebaseapp/ui/auth/phone_verfication.dart';
import 'package:firebaseapp/utils/utilities.dart';
import 'package:firebaseapp/widgets/roundedBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   bool loading=false;

   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   final firestoreUser =  FirebaseFirestore.instance.collection("User");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) {
           return AlertDialog(
              title: Text("You want to exit this app"),
              actions: [
                TextButton(onPressed: (){
                  SystemNavigator.pop();
                }, child: Text("Exit")),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),

               ],
             );
           },);
         return true;
      }
        ,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                     validator: (value){
                      if(value!.isEmpty){
                        return "enter email";
                      }else{
                        return null;
                      }
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value){
                      if(value!.isEmpty){
                        return "enter password";
                      }else{
                        return null;
                      }
                    },
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  RoundedButton(
                       loading: loading,
                       title: "Sign Up",
                      onTap: (){

                      if(emailController.text=='' || passwordController.text==''){
                        return;
                      }

                      setState(() {
                          loading = true;
                       });

                        if(globalKey.currentState!.validate()){

                          _firebaseAuth.createUserWithEmailAndPassword(
                             email: emailController.text.toString(),
                             password: passwordController.text.toString()).then((value){

                               Utils().ToastMessage("Sign Up Succesfully");
                               Navigator.push(context , MaterialPageRoute(builder: (context)=>LoginScreen()));

                               String id = DateTime.now().millisecondsSinceEpoch.toString();
                               firestoreUser.doc(id).set({
                                 "email" : emailController.text,
                                 "id" : id,
                               });

                               setState(() {
                                 loading=false;
                               });

                             }).onError((error, stackTrace) {
                                Utils().ToastMessage(error.toString().substring(37));
                                setState(() {
                                 loading=false;
                                });
                           });
                        }
                      }),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("Already  have an account"),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Login"))
                    ],
                  ),

                 const SizedBox(height: 20,),

                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneVerficationScreen()));
                    },
                    child: Container(
                        height: 50,
                        width:double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black12),

                        ),
                        child: Center(child: const Text("Login With Phone " , style: TextStyle(fontSize: 16),))),
                  ),
                  
                ],
              ),
            )),
      ),
    );
  }
}
