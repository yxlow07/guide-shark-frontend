import 'package:flutter/material.dart';
import 'package:guide_shark/common/AppStyles.dart';
import 'package:guide_shark/common/widgets/BottomNavbar.dart';

class Results extends StatelessWidget {
  final Map<String, dynamic> diagnosis;

  const Results({Key? key, required this.diagnosis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diagnosis Results')),
      body: SafeArea(
        child: Padding(
          padding: AppStyles.paddingScreen,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        diagnosis.entries.map((entry) => _buildDiseaseCard(entry.key, entry.value, context)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar.bottomNavigationBar,
    );
  }

  Widget _buildDiseaseCard(String key, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: double.infinity,
        decoration: AppStyles.results,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(key, style: AppStyles.subtitle),
              const SizedBox(height: 8),
              Text(value, style: AppStyles.body),
            ],
          ),
        ),
      ),
    );
  }
}
