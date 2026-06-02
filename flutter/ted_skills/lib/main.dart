import 'package:flutter/material.dart';
import 'screens/student_home.dart';
import 'widgets/shared_widgets.dart';

void main() {
  runApp(const TedSkillsApp());
}

class TedSkillsApp extends StatelessWidget {
  const TedSkillsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TedSkills',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// Schermata iniziale di selezione del ruolo.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF4FB),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/logo.png', fit: BoxFit.contain),
                const SizedBox(height: 10),
                const Text(
                  'Benvenuto',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Seleziona il tuo ruolo per accedere',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 48),
                RoleCard(
                  titolo: 'Entra come Studente',
                  sottotitolo: 'Accedi alla tua area studente',
                  icona: Icons.backpack_rounded,
                  coloreIcona: const Color(0xFFDBEAFD),
                  coloreTintaIcona: const Color(0xFF2563EB),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentHomeScreen()),
                  ),
                ),
                const SizedBox(height: 16),
                RoleCard(
                  titolo: 'Entra come Docente',
                  sottotitolo: 'Accedi alla tua area docente',
                  icona: Icons.school_rounded,
                  coloreIcona: const Color(0xFFD1FAE5),
                  coloreTintaIcona: const Color(0xFF059669),
                  onTap: () {}, // home page professore
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}