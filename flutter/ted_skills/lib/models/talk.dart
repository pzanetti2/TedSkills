class Talk {
  final String id;
  final String title;     
  final String details;     
  final String mainSpeaker; 
  final String url;        
  final String imageUrl;    
  final String durata;      
  final List<String> keyPhrases;

  const Talk({
    required this.id,
    required this.title,
    this.details = '',
    this.mainSpeaker = '',
    this.url = '',
    this.imageUrl = '',
    this.durata = '',
    this.keyPhrases = const [],
  });

  factory Talk.fromJson(Map<String, dynamic> json) {
    return Talk(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      details: json['description'] ?? '',
      mainSpeaker: json['speakers']?.toString() ?? '',
      url: json['url'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image_url'] ?? '',
      durata: json['durata'] ?? json['duration'] ?? '',
      keyPhrases: (json['comprehend_analysis']?['KeyPhrases'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}