import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String tileTitle = "Dashboard";
  final String imageAssetName = "assets/images/dashboard.png";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
