import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviely/blocs/homepage_search_bloc/homepage_search_bloc.dart';
import 'package:moviely/firebase_options.dart';
import 'package:moviely/pages/homepage/homepage.dart';
import 'package:moviely/repositories/firestore_repository.dart';
import 'package:moviely/repositories/tmdb_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final firestoreRepository = FirestoreRepository(prefs);

  final creds = firestoreRepository.credentials;
  final apiKey = (await creds)?.apiKey;
  final readAcessToken = (await creds)?.readAccessToken;
  final tmdb = TmdbRepository(
    apiKey: apiKey ?? "",
    readAcessToken: readAcessToken ?? "",
  );

  runApp(
    MultiBlocProvider(
      providers: [
        Provider.value(value: tmdb),
        Provider.value(value: firestoreRepository),
        BlocProvider(create: (context) => HomepageSearchBloc(tmdb)),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.pink);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: "/",
      theme: ThemeData(
        fontFamily: GoogleFonts.patrickHand().fontFamily,
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primaryContainer,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(width: 1),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
