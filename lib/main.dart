import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'MunchMate Admin',
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.lexendTextTheme(),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
