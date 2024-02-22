import 'package:flutter/material.dart';
import 'home.dart';
import 'sgnup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      "Sign in",
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
                          "Sign in",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Keep me logged in",
                            style:
                                TextStyle(color: Color.fromARGB(72, 0, 0, 0)),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 25,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        112, 158, 158, 158),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              Positioned(
                                left: 2,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccueilPage()));
                        },
                        child: Container(
                            alignment: Alignment.center,
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
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      const Divider(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => {},
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
                                "With Google",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 1.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Not a user",
                      style:
                          TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: -2.0),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
