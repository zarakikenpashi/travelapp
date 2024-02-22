import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    "Sign up",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            Form(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Join us",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: "Username",
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Repeat Password",
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: "Email Adress",
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Agree to our"),
                          Text("Terms and Stuff"),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                              "Sign up",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
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
                    "Already a member ?",
                    style: TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Sign in",
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
