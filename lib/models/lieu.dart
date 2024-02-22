class ModelLieux {
  int? id;
  String? nom;
  String? ville;
  String? description;
  String? latitude;
  String? longitude;
  String? temperature;
  String? photoUrl;

  ModelLieux({
    this.id,
    this.nom,
    this.ville,
    this.description,
    this.latitude,
    this.longitude,
    this.temperature,
    this.photoUrl,
  });

  factory ModelLieux.fromJson(Map<String, dynamic> json) {
    return ModelLieux(
      id: json['id'],
      nom: json['nom'],
      ville: json['ville'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      temperature: json['temperature'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'ville': ville,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'temperature': temperature,
      'photoUrl': photoUrl,
    };
  }
}
