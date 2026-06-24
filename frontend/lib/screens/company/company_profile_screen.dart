import 'package:flutter/material.dart';

class CompanyProfileScreen extends StatelessWidget {
  final String companyId;

  const CompanyProfileScreen({Key? key, required this.companyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Profile'),
      ),
      body: Center(
        child: Text('Company ID: $companyId'),
      ),
    );
  }
}
