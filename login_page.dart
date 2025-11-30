import 'package:flutter/material.dart';
import 'package:safepedia/transparenttextfield.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  buildBackgroundImage() => Container(
    height: double.infinity,
    width: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          fit: BoxFit.cover,
          image: AssetImage("assets/img6.avif")
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      alignment: Alignment.center,
        children: [
          buildBackgroundImage(),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //titre page
                const Text(
                  "SafePedi@",
                  style: TextStyle(
                      color: Colors.greenAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //email
                const Transparenttextfield(
                  labeltext: "Email",
                  hintText: "Donner un Email valide",
                  prefixIcone: Icons.mail,
                ),
                //creer un saut de ligne
                 const SizedBox(
                   height: 10,
                 ),
                //password
                 const Transparenttextfield(
                  labeltext: "Mot de passe ",
                   hintText: "Donner le mot de passe ",
                   isPassword: true,
                   prefixIcone: Icons.lock_rounded,
                ),
                const SizedBox(
                  height: 5,
                ),
                //mot de passe oublie
                  Container(
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: () {},
                        child: Text(
                          "Mot de passe oublié",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300
                          ),
                        )
                    ),
                  ),
                //bouton connexion
                 Container(
                   width: double.infinity,
                  alignment: Alignment.center,
                   padding:const EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     color: Colors.blue,
                     borderRadius: BorderRadius.circular(15)

                   ),
                   child:const Text(
                       "Se connecter",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 22,
                     fontWeight: FontWeight.w800
                   )
                   ),
                 ),
                SizedBox(
                  height: 10,
                ),
                //bouton pour creer un compte
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: TextButton(onPressed: () {},
                      child: Text(
                        "Creer un compte",
                        style: TextStyle(
                            color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
