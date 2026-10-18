import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notes_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool isLogin = true;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> submit() async {
    try {
      if (isLogin) {
        // 🔹 Login
        await _auth.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
      } else {
        // 🔹 Signup
        if (password.text != confirmPassword.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords do not match")),
          );
          return;
        }

        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        // 🔹 Save extra user info to Firestore
        await _firestore.collection('users').doc(userCred.user!.uid).set({
          'fullName': fullName.text.trim(),
          'email': email.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Notes App", style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 24),
                  
                  // 🔹 Full Name (only for signup)
                  if (!isLogin)
                    TextField(
                      decoration: const InputDecoration(labelText: "Full Name"),
                      controller: fullName,
                    ),
                  if (!isLogin) const SizedBox(height: 12),

                  TextField(
                    decoration: const InputDecoration(labelText: "Email"),
                    controller: email,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    controller: password,
                  ),
                  if (!isLogin) const SizedBox(height: 12),
                  if (!isLogin)
                    TextField(
                      decoration: const InputDecoration(labelText: "Confirm Password"),
                      obscureText: true,
                      controller: confirmPassword,
                    ),
                  const SizedBox(height: 24),

                  FilledButton(
                    onPressed: submit,
                    child: Text(isLogin ? "Login" : "Create Account"),
                  ),
                  TextButton(
                    onPressed: () => setState(() => isLogin = !isLogin),
                    child: Text(isLogin ? "Create new account" : "Already have an account?"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
