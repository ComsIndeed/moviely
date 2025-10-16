import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moviely/pages/settings_page/auth_widget.dart';
import 'package:moviely/repositories/firestore_repository.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children:
            [
                  AuthWidget(),
                  ListTile(
                    title: Text("Refetch API Keys"),
                    subtitle: Text(
                      "Run this if you're experiencing TMDB connection errors",
                    ),
                    leading: Icon(Icons.developer_mode),
                    onTap: () async {
                      try {
                        await Provider.of<FirestoreRepository>(
                          context,
                        ).credentials;
                        Fluttertoast.showToast(msg: "Refetched API Keys");
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Error: $e");
                      }
                    },
                  ),
                ]
                .map(
                  (e) => Center(
                    child: SizedBox(
                      width: isMobile ? double.infinity : 600,
                      child: e,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
