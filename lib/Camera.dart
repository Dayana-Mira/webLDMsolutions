import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ldmsolutions/modelos/ObtenerRespuesta.dart';
import 'package:web_ldmsolutions/repository/IdentificadorApi.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xB681F66D),
      appBar: AppBar(
          backgroundColor: Color(0xB681F66D),
          title: const Text('Saca una foto')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0A310C),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            Uint8List foto=await image.readAsBytes();

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.

                  imagePath: foto,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt,
          color: Color(0xFFF1F5F0),

        ),


      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final Uint8List imagePath;
  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  ObtenerRespuesta? _pitanga;

  @override
  void dispose() {
    _pitanga=null;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xB681F66D),
          title: const Text('ENVIAR FOTO')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        color: Color(0xB681F66D),
        child: Column(
          children: [
            Center(child: Image.memory(widget.imagePath,width: 600,height: 400,)),
            _pitanga==null?Container():Center(child: Text("${_pitanga!.nombre}",style: GoogleFonts.cinzel(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.black))),
            _pitanga==null?Container():Center(child: Text("${_pitanga!.descripcion}")),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[900], // background
                ),onPressed: ()async{
              IdentificadorApi api = new IdentificadorApi();

              dynamic pitanga=await api.EnviarFoto(widget.imagePath);

              if(pitanga is ObtenerRespuesta){
                print(pitanga.toString());
                setState((){
                  _pitanga=pitanga;


                });

              }else{

              }
            }, child: Text("ENVIAR"))
          ],
        ),
      ),
    );
  }
}

