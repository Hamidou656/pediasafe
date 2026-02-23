import 'package:flutter/material.dart';

class Historique extends StatelessWidget {
  const Historique({super.key});

  @override
  Widget build(BuildContext context) {
    final cases = [
      {"patient": "Aliou", "date": "20/02/2026"},
      {"patient": "Fatou", "date": "19/02/2026"},
      {"patient": "Mamadou", "date": "18/02/2026"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Historique")),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final c = cases[index];
          return ListTile(
            title: Text(c["patient"]!),
            subtitle: Text(c["date"]!),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Ici tu peux naviguer vers la page détail du cas
            },
          );
        },
      ),
    );
  }
}
