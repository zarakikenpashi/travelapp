import 'package:flutter/material.dart';

class AjouterLieuPage extends StatefulWidget {
  const AjouterLieuPage({super.key});

  @override
  State<AjouterLieuPage> createState() => _AjouterLieuPageState();
}

class _AjouterLieuPageState extends State<AjouterLieuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Page Ajouter un nouveau leiu"),
      ),
    );
  }
}
