
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'cas.dart';
import 'prescription.dart';
import 'parametre.dart';
import 'historique.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [

          // 🖼 Image arrière-plan
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img3.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌫 Blur + overlay
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          //   child: Container(color: Colors.white.withValues(alpha: 0.12)),
          // ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 🔹 HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "SafePedi@",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A7AFF),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                                (_) => false,
                          );
                        },
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 👨‍⚕️ PROFIL UTILISATEUR
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6)
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFF0A7AFF),
                          child: Icon(Icons.person, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Bienvenue 👋", style: TextStyle(color: Colors.grey)),
                            Text(
                              user?.email ?? "Professionnel de santé",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // 📊 STATISTIQUES
                  const Text("Tableau de bord", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      _statCard("Cas traités", "42", Icons.folder_open),
                      const SizedBox(width: 10),
                      _statCard("Prescriptions", "18", Icons.medical_services),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ⚡ ACTIONS RAPIDES
                  const Text("Actions rapides", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 12),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [

                        _actionCard(
                          context,
                          icon: Icons.add_circle,
                          title: "Nouveau cas",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NewCasePage()),
                            );
                          },
                        ),

                        _actionCard(
                          context,
                          icon: Icons.medical_services,
                          title: "Évaluer prescription",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const EvaluatePrescriptionPage()),
                            );
                          },
                        ),

                        _actionCard(
                          context,
                          icon: Icons.history,
                          title: "Historique",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const Historique()),
                            );
                          },
                        ),

                        _actionCard(
                          context,
                          icon: Icons.settings,
                          title: "Paramètres",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const parametre()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 📰 ACTIVITÉ RÉCENTE
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6)
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.notifications, color: Color(0xFF0A7AFF)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Dernière prescription évaluée il y a 10 minutes",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📊 Carte statistique
  Widget _statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0A7AFF)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // ⚡ Carte action
  Widget _actionCard(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 42, color: const Color(0xFF0A7AFF)),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
