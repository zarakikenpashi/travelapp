import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import 'home.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> onSingnUp() async {
    final url = Uri.parse(
        'https://hellostartup.000webhostapp.com/Connexion/register.php'); //Repclace Your Endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "firstName": nomController.text,
      "phone": phoneController.text,
    });

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      _formKey.currentState!.reset();
      toastification.show(
        context: context,
        title: Text('Féllicitation ! votre compte a été bien enregistré'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else {
      print('Hata: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 255, 125, 126),
              Color.fromARGB(255, 236, 38, 125)
            ])),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Inscription",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Nous rejoindre",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                      controller: nomController,
                      decoration: InputDecoration(
                        labelText: "Nom et Prénoms",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    IntlPhoneField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Telephone',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      initialCountryCode: 'CI',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                        await onSingnUp();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccueilPage(),
                          ),
                        );
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 255, 125, 126),
                                    Color.fromARGB(255, 236, 38, 125)
                                  ])),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    const Divider(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color.fromARGB(255, 255, 125, 126),
                                    Color.fromARGB(255, 236, 38, 125)
                                  ])),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Connexion Google",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.white, width: 1.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Déjà inscris ?",
                    style: TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "Connectez-vous",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: -2.0),
                      ))
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
