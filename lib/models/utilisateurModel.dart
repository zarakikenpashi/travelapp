class UtilisateurModel {
  int? id;
  int? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  String? photo_url;

  UtilisateurModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.password,
      this.photo_url});

  factory UtilisateurModel.fromJson(Map<String, dynamic> json) {
    return UtilisateurModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      photo_url: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password,
      'photo_url': photo_url,
    };
  }
}
