// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:safepedia/transparenttextfield.dart';
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   buildBackgroundImage() => Container(
//     height: double.infinity,
//     width: double.infinity,
//     decoration: const BoxDecoration(
//       image: DecorationImage(
//           colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
//           fit: BoxFit.cover,
//           image: AssetImage("assets/img6.avif")
//       ),
//     ),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//       alignment: Alignment.center,
//         children: [
//           buildBackgroundImage(),
//           SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 //titre page
//                 const Text(
//                   "SafePedi@",
//                   style: TextStyle(
//                       color: Colors.greenAccent,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 //email
//               final TextEditingController emailController = TextEditingController();
//               final TextEditingController passwordController = TextEditingController();
//                 const Transparenttextfield(
//                   controller: emailController,
//                   labeltext: "Email",
//                   hintText: "Donner un Email valide",
//                   prefixIcone: Icons.mail,
//                 ),
//                 //creer un saut de ligne
//                  const SizedBox(
//                    height: 10,
//                  ),
//                 //password
//                  const Transparenttextfield(
//                  controller:passwordController
//                   labeltext: "Mot de passe ",
//                    hintText: "Donner le mot de passe ",
//                    isPassword: true,
//                    prefixIcone: Icons.lock_rounded,
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 //mot de passe oublie
//                   Container(
//                     width: double.infinity,
//                     alignment: Alignment.bottomRight,
//                     child: TextButton(onPressed: () {},
//                         child: Text(
//                           "Mot de passe oublié",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w300
//                           ),
//                         )
//                     ),
//                   ),
//                 //bouton connexion
//
//                 ElevatedButton(
//                   onPressed: () {
//                     login();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF0A7AFF), // bleu personnalisé
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: const Text("Se connecter",style: TextStyle(fontSize: 28),),
//                 ),
//
//
//                 SizedBox(
//                   height: 10,
//                 ),
//                 //bouton pour creer un compte
//                 Container(
//                   // width: double.infinity,
//                   alignment: Alignment.center,
//
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15)
//                   ),
//                   child: TextButton(onPressed: () {},
//                       child: Text(
//                         "Creer un compte",
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600
//                         ),
//                       )
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   Future<void> login() async{
//     final auth = FirebaseAuth.instance;
//     auth.signInWithEmailAndPassword(email: emailController, password: passwordController)
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safepedia/transparenttextfield.dart';
import 'inscription.dart';
import 'acceuil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers pour les champs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Background image
  Widget buildBackgroundImage() => Container(
    height: double.infinity,
    width: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        fit: BoxFit.cover,
        image: AssetImage("assets/img6.avif"),
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titre
                const Text(
                  "SafePedi@",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                Transparenttextfield(
                  controller: emailController,
                  labeltext: "Email",
                  hintText: "Donner un Email valide",
                  prefixIcone: Icons.mail,
                ),
                const SizedBox(height: 10),

                // Mot de passe
                Transparenttextfield(
                  controller: passwordController,
                  labeltext: "Mot de passe",
                  hintText: "Donner le mot de passe",
                  isPassword: true,
                  prefixIcone: Icons.lock_rounded,
                ),
                const SizedBox(height: 5),

                // Mot de passe oublié
                Container(
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Ajouter redirection vers mot de passe oublié
                    },
                    child: const Text(
                      "Mot de passe oublié",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Bouton connexion
                ElevatedButton(
                  onPressed:(){ login();},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A7AFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Se connecter",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(height: 10),

                // Bouton créer un compte
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InscriptionPage()),
                    );
                  },
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fonction de connexion Firebase
  // Fonction de connexion Firebase
  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connexion réussie")),
      );

      // 🔑 Redirection vers la page d'accueil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Erreur de connexion")),
      );
    }
  }


}
