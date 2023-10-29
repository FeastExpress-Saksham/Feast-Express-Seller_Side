import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munchmate_admin/common/utils/colors.dart';
import 'package:munchmate_admin/features/contactUs/screens/contact_us_screen.dart';
import 'package:munchmate_admin/providers/home_provider.dart';
import 'package:munchmate_admin/providers/menu_provider.dart';
import 'package:munchmate_admin/providers/recent_orders_provider.dart';
import 'package:provider/provider.dart';

import 'features/home/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'MunchMate Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          primarySwatch: const MaterialColor(
            0xff751217,
            <int, Color>{
              50: AppColors.primaryColor,
              100: AppColors.primaryColor,
              200: AppColors.primaryColor,
              300: AppColors.primaryColor,
              400: AppColors.primaryColor,
              500: AppColors.primaryColor,
              600: AppColors.primaryColor,
              700: AppColors.primaryColor,
              800: AppColors.primaryColor,
              900: AppColors.primaryColor,
            },
          ),
          textTheme: GoogleFonts.lexendTextTheme(),
        ),
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 1100) {
              return const HomeScreen();
            } else {
              return const ContactUsScreen();
            }
          },
        ),
      ),
    );
  }
}
