import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviely/repositories/firestore_repository.dart';
import 'package:moviely/repositories/tmdb_repository.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  UserCredential? _user;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String response = "";
  bool get isValid =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    if (!isValid) {
      return;
    }
    setState(() => response = "Logging in...");
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    _user = user;
    final credentials = await Provider.of<FirestoreRepository>(
      context,
      listen: false,
    ).credentials;
    final apiKey = credentials?.apiKey ?? "";
    final readAcessToken = credentials?.readAccessToken ?? "";
    Provider.of<TmdbRepository>(
      context,
      listen: false,
    ).setCredentials(apiKey: apiKey, readAccessToken: readAcessToken);

    if (user.user != null) {
      setState(
        () => response =
            "Logged in as ${user.user!.displayName ?? user.user!.email}.",
      );
    } else {
      setState(() => response = "Login failed.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.data != null) {
          return Column(
            children: [
              SizedBox(height: 16),
              CircleAvatar(radius: 48, child: Lottie.asset('assets/girl.json')),
              Text("Logged in as"),
              Text(asyncSnapshot.data!.email!),
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 128,
                    child: CircleAvatar(
                      radius: 48,
                      // child: Icon(Icons.person, size: 64),
                      child: Lottie.asset('assets/girl.json'),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: "Email"),
                        autofillHints: const [AutofillHints.email],
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: "Password"),
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(response),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton(
                  onPressed: (isValid) ? login : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
