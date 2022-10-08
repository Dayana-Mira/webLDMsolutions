import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_ldmsolutions/Camera.dart';
import 'package:web_ldmsolutions/utils/theme_selector.dart';
import 'package:web_ldmsolutions/widgets/navigation_arrow.dart';
import 'package:camera/camera.dart';
import 'package:web_ldmsolutions/widgets/picked_image.dart';

import '../utils/view_wrapper.dart';


class HomeView extends StatefulWidget {
  final CameraDescription camera;

  const HomeView({
    super.key,
    required this.camera,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late double screenWidth;
  late double screenHeight;
  final ImagePicker _imagePicker = new ImagePicker();
  final List<String> imgList = [
    'https://res.cloudinary.com/dcdtdbc97/image/upload/v1659664193/Day/1_okcov2.jpg',
    'https://res.cloudinary.com/dcdtdbc97/image/upload/v1659664193/Day/3_g0n4to.webp',
    'https://res.cloudinary.com/dcdtdbc97/image/upload/v1659664193/Day/4_i3t0u6.jpg',
    'https://res.cloudinary.com/dcdtdbc97/image/upload/v1659664193/Day/2_ksvgs7.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(desktopView: desktopView(), mobileView: mobileView());
  }

  Widget desktopView() {
    return Stack(
      children: [
        NavigationArrow(isBackArrow: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(getFontSize(true)),
                  SizedBox(height: screenHeight * 0.07),
                  subHeader('Puedes tomar una foto', getFontSize(false)),
                  SizedBox(height: screenHeight * 0.02),
                  subHeader('O  subir una foto', getFontSize(false)),
                  SizedBox(height: screenHeight * 0.02),
                  subHeader('Y sabras si es pitanga', getFontSize(false)),
                  SizedBox(height: screenHeight * 0.02),
                  Row(children: [
                    Padding(
                      padding:  EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green[900], // background
                          ),
                          onPressed: ()async{

                        try{
                          final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
                          if(image==null){

                          }else{
                            Uint8List foto=await image.readAsBytes();
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PickedImage(imagen: foto,

                                ),
                              ),
                            );
                          }

                        }
                            catch(e){print(e);}

                      }, child: Text("TOMAR DE GALERIA")),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900], // background
                        ),

                        onPressed: ()async{
                      try{

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TakePictureScreen(camera: widget.camera,
                             
                            ),
                          ),
                        );

                      }
                      catch(e){print(e);}
                    }, child: Text("TOMAR FOTO")),
                  ],
                  )


                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            profilePicture()
          ],
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        profilePicture(),
        SizedBox(height: screenHeight * 0.02),
        header(30),
        SizedBox(height: screenHeight * 0.01),
        subHeader('Saca una foto- Sube una foto - Y sabras si es pitanga', 15),
        Row(children: [
          Padding(
            padding:  EdgeInsets.only(right: 8),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[900], // background
                ),
                onPressed: ()async{

                  try{
                    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
                    if(image==null){

                    }else{
                      Uint8List foto=await image.readAsBytes();
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PickedImage(imagen: foto,

                          ),
                        ),
                      );
                    }

                  }
                  catch(e){print(e);}

                }, child: Text("TOMAR DE GALERIA")),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green[900], // background
              ),

              onPressed: ()async{
                try{

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TakePictureScreen(camera: widget.camera,

                      ),
                    ),
                  );

                }
                catch(e){print(e);}
              }, child: Text("TOMAR FOTO")),
        ],
        )
      ],
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 400;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 350;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 300;
    } else {
      return 250;
    }
  }

  double getFontSize(bool isHeader) {
    double fontSize = screenWidth > 950 && screenHeight > 550 ? 30 : 25;
    return isHeader ? fontSize * 2.25 : fontSize;
  }

  Widget profilePicture() {
    return Container(
      height: getImageSize(),
      width: getImageSize(),

        child: new Column(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 18/8,
                autoPlay: true),
            items: imgList .map((item) =>
                Container( width: 1000, height: 800,
                  child: Center(
                    child:
                    Image.network(item, fit: BoxFit.cover, width: 1100),),),

            ).toList(),

          )]),

    );
  }

  Widget header(double fontSize) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: ThemeSelector.selectHeadline(context),
        children: <TextSpan>[
          TextSpan(text: 'Identificador de',style: TextStyle(color: Color(0xfff1f5f0),fontSize: fontSize)),
          TextSpan(text: ' Pitanga', style: TextStyle(color: Color(0xff102513),fontSize: fontSize)),
          TextSpan(text: '!',style:TextStyle(color: Color(0xfff1f5f0)))
        ],
      ),
    );
  }

  Widget subHeader(String text, double fontSize) {
    return Text(text, style: ThemeSelector.selectSubHeadline(context));
  }
}

