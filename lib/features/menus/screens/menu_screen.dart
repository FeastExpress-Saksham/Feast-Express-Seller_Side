import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final String tileTitle = "Menu";
  final String imageAssetName = "assets/images/dashboard.png";
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
