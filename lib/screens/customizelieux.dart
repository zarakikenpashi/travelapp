import 'package:flutter/material.dart';

class CustomizeLieuPage extends StatefulWidget {
  const CustomizeLieuPage({super.key});

  @override
  State<CustomizeLieuPage> createState() => _CustomizeLieuPageState();
}

class _CustomizeLieuPageState extends State<CustomizeLieuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Page Liste des Lieux"),
      ),
    );
  }
}
