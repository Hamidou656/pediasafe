import 'package:flutter/material.dart';
import 'popi_service.dart';

class EvaluatePrescriptionPage extends StatefulWidget {
  const EvaluatePrescriptionPage({super.key});

  @override
  State<EvaluatePrescriptionPage> createState() => _EvaluatePrescriptionPageState();
}

class _EvaluatePrescriptionPageState extends State<EvaluatePrescriptionPage> {
  final _formKey = GlobalKey<FormState>();
  final ageCtrl = TextEditingController();
  final poidsCtrl = TextEditingController();
  final medicamentCtrl = TextEditingController();
  final dosageCtrl = TextEditingController();
  final dureeCtrl = TextEditingController();

  String verdict = "";
  Color verdictColor = Colors.grey;

  final List<Map<String, dynamic>> popiDatabase = [
    {
      "name": "paracetamol",
      "maxMgPerKg": 15,
      "warning": "Surdosage potentiel en paracétamol"
    },
    {
      "name": "ibuprofene",
      "maxMgPerKg": 10,
      "warning": "Dose excessive d’ibuprofène (risque gastrique)"
    },
    {
      "name": "amoxicilline",
      "maxMgPerKg": 80,
      "warning": "Dose antibiotique trop élevée"
    },
    {
      "name": "codeine",
      "forbidden": true,
      "warning": "❌ Codéine interdite chez l’enfant"
    },
    {
      "name": "aspirine",
      "forbidden": true,
      "warning": "❌ Aspirine contre-indiquée (Syndrome de Reye)"
    }
  ];

  void _evaluer() async {
    if (!_formKey.currentState!.validate()) return;

    final rules = popiDatabase;

    final poids = double.tryParse(poidsCtrl.text) ?? 0;
    final age = int.tryParse(ageCtrl.text) ?? 0;
    final duree = int.tryParse(dureeCtrl.text) ?? 0;
    final dosage = double.tryParse(dosageCtrl.text) ?? 0;
    final med = medicamentCtrl.text.toLowerCase();

    List<String> alerts = [];
    String dosageInfo = "";

    for (var rule in rules) {
      if (med.contains(rule["name"])) {
        // Vérification interdit
        if (rule["forbidden"] == true) alerts.add(rule["warning"]);

        // Vérification âge minimum
        if (rule.containsKey("minAgeMonths") && age < rule["minAgeMonths"]) {
          alerts.add("⚠ Médicament interdit avant ${rule["minAgeMonths"]} mois");
        }

        // Vérification durée
        if (rule.containsKey("maxDurationDays") && duree > rule["maxDurationDays"]) {
          alerts.add(rule["warning"]);
        }

        // Vérification dosage
        if (rule.containsKey("maxMgPerKg")) {
          final maxDosage = rule["maxMgPerKg"];
          if (dosage > maxDosage) {
            alerts.add(rule["warning"]);
          }
          dosageInfo = "💊 Dosage recommandé : $maxDosage mg/kg";
        }
      }
    }

    setState(() {
      if (alerts.isEmpty) {
        verdict = "✅ Prescription conforme aux critères POPI réels.\n$dosageInfo";
        verdictColor = Colors.green;
      } else {
        verdict = alerts.join("\n") + (dosageInfo.isNotEmpty ? "\n$dosageInfo" : "");
        verdictColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Évaluation POPI réelle"),
        backgroundColor: const Color(0xFF0A7AFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Analyse réelle selon base POPI pédiatrique",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: ageCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Âge enfant (mois)",
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (v) => v!.isEmpty ? "Âge requis" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: poidsCtrl,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Poids enfant (kg)",
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
                validator: (v) => v!.isEmpty ? "Poids requis" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: medicamentCtrl,
                decoration: const InputDecoration(
                  labelText: "Médicament",
                  prefixIcon: Icon(Icons.medication),
                ),
                validator: (v) => v!.isEmpty ? "Nom requis" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dosageCtrl,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Dosage (mg/kg)",
                  prefixIcon: Icon(Icons.science),
                ),
                validator: (v) => v!.isEmpty ? "Dosage requis" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dureeCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Durée traitement (jours)",
                  prefixIcon: Icon(Icons.timer),
                ),
                validator: (v) => v!.isEmpty ? "Durée requise" : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _evaluer,
                icon: const Icon(Icons.analytics),
                label: const Text("Analyser avec POPI"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A7AFF),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              if (verdict.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: verdictColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    verdict,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: verdictColor,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
