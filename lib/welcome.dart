import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'sgnup.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    init();
    super.initState();
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
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              child: Center(
                  child: Column(
                children: [
                  MyLogo(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("ATLAS",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 30,
                      )),
                  Text(
                    "Blissful Travel",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(13)),
                      child: const Text("Login"),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()))
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(13),
                        backgroundColor:
                            const Color.fromARGB(255, 236, 38, 125),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Create an account"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(2.0, 2.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Le Logo",
            style: TextStyle(fontSize: 30),
          ),
        ));
  }
}
