import 'package:flutter/material.dart';
class Transparenttextfield extends StatefulWidget {
  final IconData prefixIcone;
  final String labeltext;
  final String hintText;
  final bool isPassword;
  final TextInputType keyBoardType;

  const Transparenttextfield({
    super.key,
    this.prefixIcone=Icons.fiber_manual_record_rounded,
    this.labeltext="pas de label",
    this.hintText="pas de hint",
    this.isPassword=false,
    this.keyBoardType=TextInputType.text,
  });
  @override
  State<Transparenttextfield> createState() => _TransparenttextfieldState();
}

class _TransparenttextfieldState extends State<Transparenttextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: widget.isPassword,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        keyboardType: widget.keyBoardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(widget.prefixIcone,color: Colors.white,size: 30),
          label: Text(
            widget.labeltext,
            style: const TextStyle(
              color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),
            ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.white60,fontSize: 17,fontWeight: FontWeight.w500),
          )
          )
        );
  }
}

