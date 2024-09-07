import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Le titre de l'AppBar
  final String titleString;
  // Le texte du bouton
  final String buttonTitle;
  // La fonction à appeler lorsque le bouton est pressé
  final VoidCallback callback;

  // Constructeur de CustomAppBar avec des paramètres requis
  CustomAppBar({
    Key? key,
    required this.titleString,
    required this.buttonTitle,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleString),
      backgroundColor: Colors.amber,
      actions: [
        TextButton(
          onPressed: callback,
          child: Text(
            buttonTitle,
            style: const TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
