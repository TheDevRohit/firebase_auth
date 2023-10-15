import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/ui/auth/verify_code.dart';
import 'package:firebaseapp/utils/utilities.dart';
import 'package:firebaseapp/widgets/roundedBtn.dart';
import 'package:flutter/material.dart';

class PhoneVerficationScreen extends StatefulWidget {
  const PhoneVerficationScreen({super.key});

  @override
  State<PhoneVerficationScreen> createState() => _PhoneVerficationScreenState();
}

class _PhoneVerficationScreenState extends State<PhoneVerficationScreen> {

  final phoneController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  var countryCode="+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Row(
              children: [
                CountryCodePicker(
                  showDropDownButton: true,
                  initialSelection: countryCode,
                  // barrierColor: Colors.red,
                  onChanged: (val) {
                    setState(() {
                      countryCode = val.toString();
                    });
                  },
                  enabled: true,
                  // alignLeft: true,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "eg :- 9090909090",
                    ),
                    keyboardType: TextInputType.text,
                    controller: phoneController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            RoundedButton(
                title: "Login",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  firebaseAuth.verifyPhoneNumber(
                      phoneNumber: "${countryCode}${phoneController.text}",
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        Utils().ToastMessage(e.toString());
                        setState(() {
                          loading = false;
                        });
                      },
                      codeSent: (String varificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCode(
                                      varificationId: varificationId,
                                    )));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().ToastMessage(e.toString());
                      });
                }),
          ],
        ),
      ),
    );
  }
}
