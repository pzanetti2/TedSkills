import 'package:ted_skills/models/talk.dart';

class RecommendedTalk extends Talk{
  final String softSkill; 

  const RecommendedTalk({
    required this.softSkill, required super.id, required super.title, super.url,
  });

  factory RecommendedTalk.fromJson(Map<String, dynamic> json) {
    return RecommendedTalk(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? json['titolo'] ?? 'Titolo non disponibile',
      softSkill: json['soft_skill'] ?? 'Competenza trasversale generica',
      url: json['url'] ?? '',
    );
  }
}

class WatchNextResponse {
  final String originalVideoId;
  final String originalTitle;
  final String softSkillInFocus;
  final List<RecommendedTalk> recommendedVideos;

  const WatchNextResponse({
    required this.originalVideoId,
    required this.originalTitle,
    required this.softSkillInFocus,
    required this.recommendedVideos,
  });

  factory WatchNextResponse.fromJson(Map<String, dynamic> json) {
    final rawList =
        json['recommended_videos'] ?? json['talks'] ?? json['videos'] ?? [];
    final lista = (rawList as List<dynamic>)
        .map((v) => RecommendedTalk.fromJson(v as Map<String, dynamic>))
        .toList();
    return WatchNextResponse(
      originalVideoId: json['original_video_id']?.toString() ?? '',
      originalTitle: json['original_title'] ?? '',
      softSkillInFocus: json['soft_skill_in_focus'] ?? '',
      recommendedVideos: lista,
    );
  }
}