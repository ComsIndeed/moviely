import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviely/pages/homepage/homepage_search.dart';
import 'package:moviely/pages/settings_page/settings_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "MOVIELY",
          style: TextStyle(
            fontFamily: GoogleFonts.patrickHand().fontFamily,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.75
              ..color = Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(child: HomepageSearch()),
                SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: Icon(Icons.person),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Your Favorites",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontFamily: GoogleFonts.patrickHand().fontFamily,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.5
                  ..color = Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 128,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 256,
                    width: 160,
                    decoration: BoxDecoration(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Recent",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontFamily: GoogleFonts.patrickHand().fontFamily,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.5
                  ..color = Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
