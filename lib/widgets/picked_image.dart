import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ldmsolutions/modelos/ObtenerRespuesta.dart';
import 'package:web_ldmsolutions/repository/IdentificadorApi.dart';
import 'package:sizer/sizer.dart';

class PickedImage extends StatefulWidget {
  final Uint8List imagen;

  const PickedImage({required this.imagen});
  @override
  State<PickedImage> createState() => _PickedImageState();
}
bool _estaCargando= false;
class _PickedImageState extends State<PickedImage> {
  ObtenerRespuesta? _pitanga;

  @override
  void dispose() {
    _pitanga=null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xB681F66D),
          title: const Text('ENVIAR FOTO')),
      body: Container(
        color: Color(0xB681F66D),
        child: Column(
          children: [
            Center(child: Image.memory(widget.imagen,width: 600,height: 400,)),
            _pitanga==null?Container():Center(child: Text("${_pitanga!.nombre}",style: GoogleFonts.cinzel(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.black))),
            _pitanga==null?Container():Center(child: Text("${_pitanga!.descripcion}")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[900], // background
                ),onPressed: ()async{

              setState((){
                _estaCargando=true;
              });

              IdentificadorApi api = new IdentificadorApi();

                  dynamic pitanga=await api.EnviarFoto(widget.imagen);

              if(pitanga is ObtenerRespuesta){
                print(pitanga.toString());
                setState((){
                  _pitanga=pitanga;
                  _estaCargando=false;

                });

              }else{
                setState((){
                  _estaCargando=false;
                });
              }
              print("click");
            }, child: Text("ENVIAR"))
          ],
        ),
      ),

    );
  }
}
