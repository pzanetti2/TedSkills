import 'package:ted_skills/models/talk.dart';

class GapFillerResponse {
  final String identifiedGap;
  final String message;
  final List<Talk> talks;

  const GapFillerResponse({
    required this.identifiedGap,
    required this.message,
    required this.talks,
  });

  factory GapFillerResponse.fromJson(Map<String, dynamic> json) {
    final talksList = (json['talks'] as List<dynamic>? ?? [])
        .map((t) => Talk.fromJson(t as Map<String, dynamic>))
        .toList();
    return GapFillerResponse(
      identifiedGap: json['identified_gap'] ?? '',
      message: json['message'] ?? '',
      talks: talksList,
    );
  }
}