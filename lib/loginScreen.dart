import 'package:finance/component/myButton.dart';
import 'package:finance/component/myTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // textfield controller
  String text = "";
  final emailController = TextEditingController();
  final passController = TextEditingController();
  void SignIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff11998e)),
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
              Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
      if (e.code == 'user-not-found') {
        setState(() {
          text = "email est incorrecte";
        });
      } else if (e.code == 'wrong-password') 
      {
        setState(() {
          text = "mot de passe incorrecte";
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Color(0xff11998e),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Bienvenu sur la page de connexion',
                  style: TextStyle(color: Colors.grey[700], fontSize: 18),
                ),
                SizedBox(
                  height: 25,
                ),
                myTextField(
                  controler: emailController,
                  hindText: "E-mail",
                  obscured: false,
                  type: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                myTextField(
                  controler: passController,
                  hindText: "Mot de passe",
                  obscured: true,
                  type: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                Mybutton(
                  text: "Se connectez",
                  onTap: SignIn,
                ),
                Center(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
