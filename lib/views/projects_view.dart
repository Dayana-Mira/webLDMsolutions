import 'package:flutter/material.dart';
import 'package:web_ldmsolutions/utils/theme_selector.dart';
import 'package:web_ldmsolutions/utils/view_wrapper.dart';
import 'package:web_ldmsolutions/widgets/project_entry.dart';

import '../utils/project_model.dart';
import '../widgets/navigation_arrow.dart';
import '../widgets/project_image.dart';


class ProjectsView extends StatefulWidget {

  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  late double screenWidth;
  late double screenHeight;
  int selectedIndex = 0;
  List<Project> projects = [
    Project(
        title: 'Equipo',
        imageURL: 'project1.jpg',
        description:
        'El equipo esta compuesto por tres integrantes, ubicados en distintas regiones del pais, Mercedes, Salto y Juan lacaze'),
    Project(
        title: 'Propuesta',
        imageURL: 'project2.jpg',
        description:
        'El trabajo propone la generación de un modelo de clasificación para la identificación del árbol de pitanga (Eugenia uniflora), el mismo es uno de los árboles autóctonos más representativos de la rivera del río Yi. Las especies agrupadas en dicha región aportan un valor fundamental para el ecosistema local como también en aplicaciones industriales. Las crecientes necesidades ecológicas y proyectos que impulsan la reforestación en el río Yi, presentan la necesidad de mantener un control de las diferentes especies agilizando el proceso de clasificación de las mismas. '),
    Project(
        title: 'Construcción',
        imageURL: 'project3.jpg',
        description:
        'Obtención de datos-> El tipo de dato corresponde a datos no estructurados '
            'Pre-procesado de datos -> Es donde vamos a “transformar” la información antes, para hacer más fácil el procesamiento de las siguientes etapas por ejemplo muchas imágenes pueden contener ruido o exceso de brillo, o contengan información que luego dificulte la correcta extracción de características por parte del modelo, estandarización del tamaño de la imagen.'
            'Procesado de Imágenes->Esta etapa consta de las siguientes 5 técnicas ,Detección de Bordes, Umbralización, Segmentación Orientada a Regiones, Filtro de Media  y Filtro de Mediana'
            'Modelado de Red Neuronal->Para este proyecto seleccionamos las RNC por ser la estructura que mejor se adapta de acuerdo a lo investigado, al trabajo con imágenes y demás características del problema planteado. La RNC recibe la imagen procesada en las etapas previas, con el fin de optimizar el tiempo de entrenamiento y el costo computacional del trabajo de inteligencia artificial. Esta imagen pasa por varias capas especializadas dentro de la red neuronal, que determinan específicamente 3 funciones: CONVULSION, AGRUPACION y NEURONAS TOTALEMENTE CONECTADAS.'
            'Clasificación-> la última etapa del proceso iterativo que se repetirá cuantas veces sea necesario hasta lograr un modelo entrenado que cumpla con las expectativas del proyecto a la hora de realizar la clasificación de las imágenes.'
            'TEST-> para determinar el que mejor se adapte a nuestras necesidades se plantea utilizar herramientas de análisis.'
    )
  ];
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('project1.jpg'), context);
    precacheImage(const AssetImage('project2.jpg'), context);
    precacheImage(const AssetImage('project3.jpg'), context);
    super.didChangeDependencies();
  }

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
    double space = MediaQuery.of(context).size.height * 0.03;
    List<Widget> images =
        List.generate((projects.length * 1.5).ceil(), (index) {
      if (index.isEven) {
        return ProjectImage(
            project: projects[index ~/ 2],
            onPressed: () => updateIndex(index ~/ 2));
      } else {
        return SizedBox(height: space);
      }
    });
    return Stack(
      children: [
        NavigationArrow(isBackArrow: true),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05, horizontal: screenWidth * 0.1),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: images,
                ),
                SizedBox(width: space),
                Container(
                  height: screenHeight * 0.2 * 2 + space * 2,
                  child: Stack(
                    children: [
                      AnimatedAlign(
                        alignment: selectedIndex == 0
                            ? Alignment.topCenter
                            : selectedIndex == 1
                                ? Alignment.center
                                : Alignment.bottomCenter,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          color: Colors.white,
                          width: screenWidth * 0.05,
                          height: 3,

                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: space),
                Expanded(child: ProjectEntry(project: projects[selectedIndex]))
              ],
            ))
      ],
    );
  }

  Widget mobileView() {
    List<Widget> projectList = List.generate(projects.length, (index) {
      return Column(
        children: [
          Text(
            projects[index].title,
            style: ThemeSelector.selectSubHeadline(context),

          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                projects[index].imageURL,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            projects[index].description,
            style: ThemeSelector.selectBodyText(context),
          ),
          SizedBox(height: screenHeight * 0.1),
        ],
      );
    });
    return Column(children: projectList);
  }

  void updateIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}
