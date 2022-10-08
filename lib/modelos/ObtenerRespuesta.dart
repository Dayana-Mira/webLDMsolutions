import 'package:json_annotation/json_annotation.dart';

part 'ObtenerRespuesta.g.dart';
@JsonSerializable()
class ObtenerRespuesta{
  String descripcion ;
  int id ;
  String nombre ;

  @override
  String toString() {
    return 'ObtenerRespuesta{descripcion: $descripcion, id: $id, nombre: $nombre}';
  }

  ObtenerRespuesta(this.descripcion, this.id, this.nombre);

  factory ObtenerRespuesta.fromJson(Map<String, dynamic> json) =>
      _$ObtenerRespuestaFromJson(json);
  Map<String, dynamic> toJson() => _$ObtenerRespuestaToJson(this);
}