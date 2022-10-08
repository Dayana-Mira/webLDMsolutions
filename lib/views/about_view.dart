import 'package:flutter/material.dart';

import 'package:web_ldmsolutions/utils/view_wrapper.dart';

import '../utils/theme_selector.dart';
import '../widgets/bullet_list.dart';
import '../widgets/navigation_arrow.dart';

class AboutView extends StatefulWidget {

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with TickerProviderStateMixin  {
  late double screenWidth;
  late double screenHeight;
  String beneficios =
      'La especie Eugenia Uniflora - Pitanga, se identifica por su fruto  y la dificultad que presenta es que su hoja puede ser confundida con otras especies de la zona, inclusive para los mismos investigadores altamente entrenados.';
  String beneficios1 =
      'El fruto posee muchos nutrientes: vitaminas A, B y C, calcio, fósforo y hierro, y compuestos fenólicos como flavonoides, carotenoides y antocianinas, tiene propiedades antioxidantes, antiinflamatorias, analgésicas y antihipertensivas.';
  String beneficios2 =
      'Ayuda a mantener la piel sana y bonita y una buena visión, además de ser muy útil para ayudar a adelgazar, porque tiene pocas calorías, es nutritiva y posee acción diurética, reduciendo la hinchazón del cuerpo.';
  String beneficios3 =
      'Se puede consumir en su forma natural o usarse en dulces, mermeladas, helados y refrescos.';
  String beneficios4 =
      'Protege contra enfermedades cardiovasculares, Combate la artritis y la gota, Mejora la salud de los ojos, Mejora la calidad de la piel, Combate problemas respiratorios, Elimina hongos y bacterias, Reduce la hinchazón.';
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        NavigationArrow(isBackArrow: false),
        NavigationArrow(isBackArrow: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Expanded(flex: 3, child: infoSection()),
            Spacer(flex: 1),
            Expanded(
                flex: 3,
                child: BulletList(

                  strings: [beneficios1, beneficios2, beneficios3, beneficios4],
                )),
            Spacer(flex: 1),
          ],
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.05),
        infoText(),
        SizedBox(height: screenHeight * 0.05),
        Container(

            height: getImageSize(),
            width: getImageSize(),
            child:ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/6.jpg',
                  fit: BoxFit.cover,)
            )

        ),
        Container(
          height: screenHeight * 0.3,
          child: BulletList(
            strings: [beneficios1, beneficios2, beneficios3, beneficios4],
          ),

        ),

      ],
    );

  }

  Widget infoSection() {
    return Container(
      width: screenWidth * 0.35,
      child: Column(
        children: [
          profilePicture(),
          SizedBox(height: screenHeight * 0.05),
          infoText()
        ],
      ),
    );
  }

  Widget profilePicture() {
    return Container(

      height: getImageSize(),
      width: getImageSize(),
      child:ClipRRect(
        borderRadius: BorderRadius.circular(100),
          child: Image.asset('assets/6.jpg',
          fit: BoxFit.cover,)
      )

    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 350;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 300;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 200;
    } else {
      return 150;
    }
  }

  Widget infoText() {
    return Text(
      'La especie Eugenia Uniflora - Pitanga, se identifica por su fruto mayormente y la dificultad que presenta es que su hoja puede ser confundida por otras especies de la zona  para el ojo humano, inclusive los mismos investigadores altamente entrenados.',
      overflow: TextOverflow.clip,


      style: ThemeSelector.selectBodyText(context),

    );
  }

}
