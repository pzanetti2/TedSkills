import 'package:flutter/material.dart';
import '../widgets/shared_widgets.dart';
import 'get_by_tag.dart';
import 'get_fewer_skill.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FB),
      appBar: buildTedSkillsAppBar(context: context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ActionCard(
                titolo: 'Ricerca per Tag',
                sottotitolo: 'Trova talk filtrandoli attraverso tag specifici',
                icona: Icons.tag_rounded,
                coloreIcona: const Color(0xFFDBEAFD),
                coloreTintaIcona: const Color(0xFF2563EB),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GetByTagScreen()),
                ),
              ),
              const SizedBox(height: 16),
              ActionCard(
                titolo: 'Potenzia le tue skills',
                sottotitolo: 'Scopri talk in base alla tua skill meno sviluppata',
                icona: Icons.trending_down_rounded,
                coloreIcona: const Color(0xFFD1FAE5),
                coloreTintaIcona: const Color(0xFF059669),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SkillGapFillerScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}