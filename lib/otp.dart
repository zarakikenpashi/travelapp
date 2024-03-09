import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  /// Create key
  final formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 236, 38, 125),
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          "Vérification",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Entrez le code que vous avez reçu"),
          SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Pinput(
              controller: pinController,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text("Vous n'avez pas reçu de code ?"),
          TextButton(onPressed: () {}, child: Text("Renvoyer"))
        ]),
      ),
    );
  }
}
