import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onCancel;
  VoidCallback onAdded;
  
  AddDialog({super.key, required this.controller, required this.onAdded, required this.onCancel});
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter une liste"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Entrez le nom de la nouvelle liste"
        ),
      ),
      actions: [
        TextButton(onPressed: onAdded, child: const Text("Valider")),
        TextButton(onPressed: onCancel, child: const Text("Annuler"))
      ],
    );
  }
}