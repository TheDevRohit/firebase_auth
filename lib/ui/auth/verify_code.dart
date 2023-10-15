import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/Home/home_page.dart';
import 'package:firebaseapp/utils/utilities.dart';
import 'package:firebaseapp/widgets/roundedBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class VerifyCode extends StatefulWidget {
  final String varificationId;

  VerifyCode({super.key, required this.varificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  var otpController = TextEditingController();


  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading=false;
  var OtpValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Verify "),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),


            // TextFormField(
            //   decoration: InputDecoration(
            //     hintText: "6 digit Otp",
            //   ),
            //   keyboardType: TextInputType.text,
            //   controller: otpController,
            // ),

            Container(
              height: 70,
               child: VerificationCode(
                onCompleted: (String value) {
                  setState(() {
                    OtpValue = value.toString();
                  });
                  print(value);
                },
                onEditing: (bool value) {

                },
                 digitsOnly: true,
                 length: 6,
              ),
            ),


            const SizedBox(
              height: 50,
            ),
            RoundedButton(
              loading: loading,
                title: "Verify",
                onTap: () async {

                  setState(() {
                  loading =true;
                   });

                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.varificationId,
                      smsCode: OtpValue);

                  try {
                    await auth.signInWithCredential(credential);
                    setState(() {
                      loading=false;
                    });
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context)=>const Homepage()));

                  } catch (e) {
                    setState(() {
                      loading=false;
                    });
                    Utils().ToastMessage(e.toString());
                  }
                })
          ]),
        ));
  }
}
