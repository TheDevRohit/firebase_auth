import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  String title;
  VoidCallback onTap;
  bool loading;

  RoundedButton({super.key ,required this.title ,required this.onTap , this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: loading ? CircularProgressIndicator(color: Colors.yellowAccent,) : Text( title,style: TextStyle(fontSize: 20 , color: Colors.white),)),
      ),
    );
  }
}
