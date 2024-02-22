class ActiviteModel {
  int? id;
  int? lieu_id;
  String? nom_activite;
  double? longitude;
  double? latitude;
  String? email;
  String? tel_responsable;
  String? image_activite;
  String? bref_description;
  String? description_complete;

  ActiviteModel(
      {this.id,
      this.lieu_id,
      this.nom_activite,
      this.longitude,
      this.latitude,
      this.email,
      this.tel_responsable,
      this.image_activite,
      this.bref_description,
      this.description_complete});

  factory ActiviteModel.fromJson(Map<String, dynamic> json) {
    return ActiviteModel(
      id: json['id'],
      lieu_id: json['lieu_id'],
      nom_activite: json['nom_activite'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      email: json['email'],
      tel_responsable: json['tel_responsable'],
      image_activite: json['image_activite'],
      bref_description: json['bref_description'],
      description_complete: json['description_complete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lieu_id': lieu_id,
      'nom_activite': nom_activite,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'tel_responsable': tel_responsable,
      'image_activite': image_activite,
      'bref_description': bref_description,
      'description_complete': description_complete,
    };
  }
}
