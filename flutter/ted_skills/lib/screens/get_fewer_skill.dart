import 'package:flutter/material.dart';
import '../models/gap_filler.dart';
import '../models/talk.dart';
import '../repositories/talk_repository.dart';
import '../widgets/shared_widgets.dart';
import 'watch_next.dart';

class SkillGapFillerScreen extends StatefulWidget {
  const SkillGapFillerScreen({super.key});

  @override
  State<SkillGapFillerScreen> createState() => _SkillGapFillerScreenState();
}

class _SkillGapFillerScreenState extends State<SkillGapFillerScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  GapFillerResponse? _response;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      final result = await getGapFiller(kPortfolio);
      setState(() { _response = result; _isLoading = false; });
    } catch (e) {
      setState(() {
        _errorMessage = 'Impossibile raggiungere il server.\nControlla la connessione e riprova.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: buildTedSkillsAppBar(context: context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF2563EB)));
    }
    if (_errorMessage != null) {
      return ErrorState(message: _errorMessage!, onRetry: _fetch);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkillChartCard(),
          const SizedBox(height: 16),

          if (_response != null) _MessageBanner(message: _response!.message),
          const SizedBox(height: 24),

          const Text(
            'Talk suggeriti per te',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827), letterSpacing: -0.3),
          ),
          const SizedBox(height: 12),

          if (_response != null)
            ..._response!.talks.map(
              (talk) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TalkCard(talk: talk),
              ),
            ),
        ],
      ),
    );
  }
}

class _SkillChartCard extends StatelessWidget {
  const _SkillChartCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
          BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Image.asset('assets/image/grafico.png', fit: BoxFit.contain),
    );
  }
}

class _MessageBanner extends StatelessWidget {
  final String message;
  const _MessageBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF059669),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
      ),
    );
  }
}

class _TalkCard extends StatelessWidget {
  final Talk talk;
  const _TalkCard({required this.talk});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
          BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(talk.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF111827), letterSpacing: -0.2)),
          const SizedBox(height: 6),
          Text(talk.details,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.4)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WatchNextScreen(
                    talk: Talk(
                      id: talk.id,
                      title: talk.title,
                      url: talk.url,
                    ),
                  ),
                ),
              ),
              icon: const Icon(Icons.open_in_new, size: 16, color: Colors.white),
              label: const Text('Guarda il talk',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}