import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/Home/home_page.dart';
import 'package:firebaseapp/ui/auth/forgot_password.dart';
import 'package:firebaseapp/ui/auth/signup_screen.dart';
import 'package:firebaseapp/utils/utilities.dart';
import 'package:firebaseapp/widgets/roundedBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   bool loading = false;

   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Firebase App"),
          automaticallyImplyLeading: false,
        ),
        body: Form(
            child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 30),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
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
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 30,),
              RoundedButton(
                  loading: loading,
                  title: "Sign in",
                  onTap: (){
                    setState(() {
                      loading=true;
                    });
                   auth.signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString()
                       ).then((value) {
                       Utils().ToastMessage(value.user!.email.toString());
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage()));
                       setState(() {
                         loading=false;
                       });
                    }).onError((error, stackTrace) {
                        Utils().ToastMessage(error.toString());
                        setState(() {
                          loading=false;
                        });
                   });
              }),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPasswordScreen()));
                }, child: const Text("Forgot Password")),
              ),

               Row(
                children: [
                  const Text("Don't have an account "),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  }, child: const Text("Sign up"))
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
