
import 'package:flutter/material.dart';
import 'auth_service.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();

  final nomCtrl = TextEditingController();
  final prenomCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final telCtrl = TextEditingController();
  final structureCtrl = TextEditingController();

  String role = 'Médecin';
  bool loading = false;

  @override
  void dispose() {
    nomCtrl.dispose();
    prenomCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    telCtrl.dispose();
    structureCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌄 Background Image
          SizedBox.expand(
            child: Image.asset(
              'assets/ins.png', // mettre votre image dans assets/
              fit: BoxFit.cover,
            ),
          ),

          // 🎨 Formulaire avec overlay
          Container(
            color: Colors.black.withValues(alpha: 0.1), // semi-transparent
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  color: Colors.blue.withValues(alpha: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Créer un compte",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 20),

                          _buildTextField(nomCtrl, "Nom"),
                          _buildTextField(prenomCtrl, "Prénom"),
                          _buildTextField(emailCtrl, "Email",
                              keyboard: TextInputType.emailAddress),
                          _buildTextField(passwordCtrl, "Mot de passe",
                              obscure: true),
                          _buildTextField(confirmCtrl, "Confirmer mot de passe",
                              obscure: true,
                              validator: (v) => v != passwordCtrl.text
                                  ? "Les mots de passe ne correspondent pas"
                                  : null),
                          _buildTextField(telCtrl, "Téléphone",
                              keyboard: TextInputType.phone),
                          _buildTextField(structureCtrl, "Hôpital / Structure"),

                          DropdownButtonFormField<String>(
                            value: role,
                            decoration:
                            const InputDecoration(labelText: "Rôle"),
                            items: const [
                              DropdownMenuItem(
                                  value: 'Médecin', child: Text('Médecin')),
                              DropdownMenuItem(
                                  value: 'Pharmacien',
                                  child: Text('Pharmacien')),
                              DropdownMenuItem(
                                  value: 'Infirmier',
                                  child: Text('Infirmier')),
                            ],
                            onChanged: (value) => setState(() => role = value!),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16)),
                              onPressed: loading ? null : _inscrire,
                              child: loading
                                  ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                "S’inscrire",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label,
      {bool obscure = false,
        TextInputType keyboard = TextInputType.text,
        String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white70,
        ),
        obscureText: obscure,
        keyboardType: keyboard,
        validator: validator ??
                (v) => v == null || v.isEmpty ? "Champ obligatoire" : null,
      ),
    );
  }

  Future<void> _inscrire() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await AuthService().registerUser(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text,
        nom: nomCtrl.text.trim(),
        prenom: prenomCtrl.text.trim(),
        role: role,
        hopital: structureCtrl.text.trim(),
        telephone: telCtrl.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Compte créé avec succès")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }

    if (mounted) setState(() => loading = false);
  }
}
