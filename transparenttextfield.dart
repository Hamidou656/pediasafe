// import 'package:flutter/material.dart';
// class Transparenttextfield extends StatefulWidget {
//   final IconData prefixIcone;
//   final String labeltext;
//   final String hintText;
//   final bool isPassword;
//   final TextInputType keyBoardType;
//   final TextEditingController controller;
//
//   const Transparenttextfield({
//     super.key,
//     this.prefixIcone=Icons.fiber_manual_record_rounded,
//     this.labeltext="pas de label",
//     this.hintText="pas de hint",
//     this.isPassword=false,
//     this.keyBoardType=TextInputType.text,
//     required this.controller,
//   });
//   @override
//   State<Transparenttextfield> createState() => _TransparenttextfieldState();
// }
//
// class _TransparenttextfieldState extends State<Transparenttextfield> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       decoration: BoxDecoration(
//         color: Colors.blueGrey.withValues(alpha: 0.5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//
//       child: TextField(
//           controller: widget.controller,
//         obscureText: widget.isPassword,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.w400,
//         ),
//         keyboardType: widget.keyBoardType,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(vertical: 10),
//           prefixIcon: Icon(widget.prefixIcone,color: Colors.white,size: 30),
//           label: Text(
//             widget.labeltext,
//             style: const TextStyle(
//               color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300),
//             ),
//           hintText: widget.hintText,
//           hintStyle: const TextStyle(
//             color: Colors.white60,fontSize: 17,fontWeight: FontWeight.w500),
//           )
//           )
//         );
//   }
// }
//
import 'package:flutter/material.dart';

class Transparenttextfield extends StatefulWidget {
  final IconData prefixIcone;
  final String labeltext;
  final String hintText;
  final bool isPassword;
  final TextInputType keyBoardType;
  final TextEditingController controller;

  const Transparenttextfield({
    super.key,
    required this.controller,
    this.prefixIcone = Icons.fiber_manual_record_rounded,
    this.labeltext = "pas de label",
    this.hintText = "pas de hint",
    this.isPassword = false,
    this.keyBoardType = TextInputType.text,
  });

  @override
  State<Transparenttextfield> createState() => _TransparenttextfieldState();
}

class _TransparenttextfieldState extends State<Transparenttextfield> {
  bool _obscure = true; // pour cacher/montrer le mot de passe

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.5), // correction de withOpacity
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscure : false,
        keyboardType: widget.keyBoardType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          prefixIcon: Icon(
            widget.prefixIcone,
            color: Colors.white,
            size: 30,
          ),
          label: Text(
            widget.labeltext,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.white60,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
          // si c'est un mot de passe, ajoute l'icône œil
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
