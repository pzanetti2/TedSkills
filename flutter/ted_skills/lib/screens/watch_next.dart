import 'package:flutter/material.dart';
import '../models/talk.dart';
import '../models/watch_next.dart';
import '../repositories/talk_repository.dart';
import '../widgets/shared_widgets.dart';

class WatchNextScreen extends StatefulWidget {
  final Talk talk;
  const WatchNextScreen({super.key, required this.talk});

  @override
  State<WatchNextScreen> createState() => _WatchNextScreenState();
}

class _WatchNextScreenState extends State<WatchNextScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  WatchNextResponse? _response;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      final result = await getWatchNext(widget.talk.id);
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
      appBar: buildTedSkillsAppBar(context: context, useTextBack: false),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MainTalkCard(talk: widget.talk),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              'Continua a sviluppare questa soft skill',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF059669), letterSpacing: -0.2),
            ),
          ),
          const SizedBox(height: 12),
          if (_response != null)
            ..._response!.recommendedVideos.map(
              (video) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SuggestedTalkCard(video: video),
              ),
            ),
        ],
      ),
    );
  }
}

class _MainTalkCard extends StatelessWidget {
  final Talk talk;
  const _MainTalkCard({required this.talk});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Stack(
              children: [
                talk.imageUrl.isNotEmpty
                    ? Image.network(
                        talk.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const _ImageFallback(),
                      )
                    : const _ImageFallback(),
                if (talk.durata.isNotEmpty)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(talk.durata,
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.4)),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(talk.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827), letterSpacing: -0.3, height: 1.3)),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14),
                    children: [
                      const TextSpan(text: 'Speaker: ', style: TextStyle(color: Color(0xFF6B7280))),
                      TextSpan(
                        text: talk.mainSpeaker,
                        style: const TextStyle(color: Color(0xFFB45309), fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: const Color(0xFFE5E7EB),
      child: const Icon(Icons.ondemand_video_rounded, size: 48, color: Color(0xFF9CA3AF)),
    );
  }
}

class _SuggestedTalkCard extends StatelessWidget {
  final RecommendedTalk video;
  const _SuggestedTalkCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: const Color(0xFFE53E3E), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(video.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827), letterSpacing: -0.1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4)
              ],
            ),
          ),
        ],
      ),
    );
  }
}