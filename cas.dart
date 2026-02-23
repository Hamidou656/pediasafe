import 'package:flutter/material.dart';
import 'prescription.dart';

class NewCasePage extends StatefulWidget {
  const NewCasePage({super.key});

  @override
  State<NewCasePage> createState() => _NewCasePageState();
}

class _NewCasePageState extends State<NewCasePage> {
  final _formKey = GlobalKey<FormState>();

  final ageCtrl = TextEditingController();
  final poidsCtrl = TextEditingController();
  final pathologieCtrl = TextEditingController();
  final observationCtrl = TextEditingController();

  String sexe = 'Masculin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image arrière-plan
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pediatrie.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
          Container(color: Colors.white.withValues(alpha: 0.9)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      "Nouveau cas pédiatrique",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A7AFF),
                      ),
                    ),
                    const SizedBox(height: 25),

                    TextFormField(
                      controller: ageCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Âge (en mois ou années)",
                        prefixIcon: Icon(Icons.cake),
                      ),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Champ obligatoire" : null,
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: poidsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Poids (kg)",
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Champ obligatoire" : null,
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      value: sexe,
                      decoration: const InputDecoration(
                        labelText: "Sexe",
                        prefixIcon: Icon(Icons.person),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "Masculin", child: Text("Masculin")),
                        DropdownMenuItem(
                            value: "Féminin", child: Text("Féminin")),
                      ],
                      onChanged: (v) => setState(() => sexe = v!),
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: pathologieCtrl,
                      decoration: const InputDecoration(
                        labelText: "Pathologie principale",
                        prefixIcon: Icon(Icons.medical_information),
                      ),
                      validator: (v) =>
                      v == null || v.isEmpty ? "Champ obligatoire" : null,
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: observationCtrl,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Observations (optionnel)",
                        prefixIcon: Icon(Icons.notes),
                      ),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: _continuer,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text(
                        "Continuer vers la prescription",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color(0xFF0A7AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _continuer() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EvaluatePrescriptionPage(
          // age: ageCtrl.text,
          // poids: poidsCtrl.text,
          // sexe: sexe,
          // pathologie: pathologieCtrl.text,
        ),
      ),
    );
  }
}
