class HotelModel {
  int? id;
  int? lieu_id;
  String? nom_hotel;
  double? longitude;
  double? latitude;
  String? email;
  String? tel_responsable;
  String? image_hotel;
  String? bref_description;
  String? description_complete;

  HotelModel(
      {this.id,
      this.lieu_id,
      this.nom_hotel,
      this.longitude,
      this.latitude,
      this.email,
      this.tel_responsable,
      this.image_hotel,
      this.bref_description,
      this.description_complete});

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      lieu_id: json['lieu_id'],
      nom_hotel: json['nom_hotel'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      email: json['email'],
      tel_responsable: json['tel_responsable'],
      image_hotel: json['image_hotel'],
      bref_description: json['bref_description'],
      description_complete: json['description_complete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lieu_id': lieu_id,
      'nom_hotel': nom_hotel,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'tel_responsable': tel_responsable,
      'image_hotel': image_hotel,
      'bref_description': bref_description,
      'description_complete': description_complete,
    };
  }
}
