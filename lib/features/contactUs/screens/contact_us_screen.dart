import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  final String tileTitle = "Contact Us";
  final String imageAssetName = "assets/images/contact-us.png";
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
