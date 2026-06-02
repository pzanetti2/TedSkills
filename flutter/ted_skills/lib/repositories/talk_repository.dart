import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/talk.dart';
import '../models/gap_filler.dart';
import '../models/watch_next.dart';

const String _kTagEndpoint =
    'https://37vdsdp9hj.execute-api.us-east-1.amazonaws.com/default/Get_Talks_By_Tag';

const String _kGapFillerEndpoint =
    'https://lmmfkp4v9g.execute-api.us-east-1.amazonaws.com/default/Get_Fewer_Skill';

const String _kWatchNextEndpoint =
    'https://utslqtzn25.execute-api.us-east-1.amazonaws.com/default/Get_Watch_Next';


const Map<String, int> kPortfolio = {
  'Leadership': 15,
  'Sostenibilità': 2,
  'Empatia': 5,
};

Future<List<Talk>> initEmptyList() async {
  return [];
}

Future<List<Talk>> getTalksByTag(String tag, int page) async {
  final response = await http.post(
    Uri.parse(_kTagEndpoint),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'tag': tag, 'page': page, 'doc_per_page': 6}),
  );

  if (response.statusCode == 200) {
    final body = utf8.decode(response.bodyBytes);
    final List<dynamic> jsonList = json.decode(body);
    return jsonList.map((j) => Talk.fromJson(j)).toList();
  } else {
    throw Exception('Errore nel caricamento dei talk (${response.statusCode})');
  }
}

Future<GapFillerResponse> getGapFiller(Map<String, int> portfolio) async {
  final response = await http
      .post(
        Uri.parse(_kGapFillerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'portfolio': portfolio}),
      )
      .timeout(const Duration(seconds: 15));

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return GapFillerResponse.fromJson(decoded);
  } else {
    throw Exception('Errore dal server (${response.statusCode})');
  }
}

Future<WatchNextResponse> getWatchNext(String talkId) async {
  final response = await http
      .post(
        Uri.parse(_kWatchNextEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': talkId}),
      )
      .timeout(const Duration(seconds: 15));

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return WatchNextResponse.fromJson(decoded);
  } else {
    throw Exception('Errore dal server (${response.statusCode})');
  }
}