import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.titolo,
    required this.sottotitolo,
    required this.icona,
    required this.coloreIcona,
    required this.coloreTintaIcona,
    required this.onTap,
  });

  final String titolo;
  final String sottotitolo;
  final IconData icona;
  final Color coloreIcona;
  final Color coloreTintaIcona;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
              BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: coloreIcona, shape: BoxShape.circle),
                child: Icon(icona, size: 26, color: coloreTintaIcona),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titolo,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827), letterSpacing: -0.2)),
                    const SizedBox(height: 3),
                    Text(sottotitolo,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: coloreTintaIcona, height: 1.3)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFFD1D5DB)),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.titolo,
    required this.sottotitolo,
    required this.icona,
    required this.coloreIcona,
    required this.coloreTintaIcona,
    required this.onTap,
  });

  final String titolo;
  final String sottotitolo;
  final IconData icona;
  final Color coloreIcona;
  final Color coloreTintaIcona;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
              BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: coloreIcona, shape: BoxShape.circle),
                child: Icon(icona, size: 26, color: coloreTintaIcona),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titolo,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827), letterSpacing: -0.2)),
                    const SizedBox(height: 4),
                    Text(sottotitolo,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: coloreTintaIcona, height: 1.4)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFFD1D5DB)),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar buildTedSkillsAppBar({
  required BuildContext context,
  bool useTextBack = false,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    title: const Text(
      'TedSkills',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A2E),
        letterSpacing: -0.3,
      ),
    ),
    leading: useTextBack
        ? TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF374151)),
            label: const Text('Indietro', style: TextStyle(fontSize: 14, color: Color(0xFF374151), fontWeight: FontWeight.w500)),
            style: TextButton.styleFrom(padding: const EdgeInsets.only(left: 8), foregroundColor: const Color(0xFF374151)),
          )
        : IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
            onPressed: () => Navigator.pop(context),
          ),
  );
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorState({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 48, color: Color(0xFFD1D5DB)),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text('Riprova', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}