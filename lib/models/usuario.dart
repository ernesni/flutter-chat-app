// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    int idUser;
    String name;
    String email;
    bool online;

    Usuario({
        required this.idUser,
        required this.name,
        required this.email,
        required this.online,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUser: json["id_user"],
        name: json["name"],
        email: json["email"],
        online: json["online"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "online": online,
    };
}
