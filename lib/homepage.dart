import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:web_ldmsolutions/utils/content_view.dart';
import 'package:web_ldmsolutions/utils/tab_controller_handler.dart';
import 'package:web_ldmsolutions/utils/view_wrapper.dart';
import 'package:web_ldmsolutions/views/about_view.dart';
import 'package:web_ldmsolutions/views/home_view.dart';
import 'package:web_ldmsolutions/views/projects_view.dart';
import 'package:web_ldmsolutions/widgets/custom_tab.dart';
import 'package:web_ldmsolutions/widgets/custom_tab_bar.dart';
import 'package:web_ldmsolutions/widgets/bottom_bar.dart';



class HomePage extends StatefulWidget {

  const HomePage({
    super.key,
    required this.camera,
  });

  final  CameraDescription camera;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin  {

  late TabController tabController;
  late ItemScrollController itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late CameraDescription camera2 ;


  late double screenHeight;
  late double screenWidth;
  late double topPadding;
  late double bottomPadding;
  late double sidePadding;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.03;
    sidePadding = screenWidth * 0.05;

    List<ContentView> contentViews = [
      ContentView(
        tab: CustomTab(title: 'Inicio'),
        content: HomeView(camera:widget.camera),
      ),
      ContentView(
        tab: CustomTab(title: 'Beneficios'),
        content: AboutView(),
      ),
      ContentView(
        tab: CustomTab(title: 'Proyecto'),
        content: ProjectsView(),
      )
    ];
    tabController = TabController(length: contentViews.length, vsync: this);
    itemScrollController = ItemScrollController();
    print('Width: $screenWidth');
    print('Height: $screenHeight');
    return Scaffold(
      backgroundColor: Color(0xB681F66D),
      key: scaffoldKey,
      endDrawer: Container(
        width: screenWidth * 0.5,
        child: Drawer(
          child: ListView(
            children: [Container(
                height: screenHeight * 0.1)] +
                contentViews
                    .map((e) => Container(
                  child: ListTile(
                    title: Text(
                      e.tab.title,
                      style: Theme.of(context).textTheme.button,
                    ),
                    onTap: () {
                      itemScrollController.scrollTo(
                          index: contentViews.indexOf(e),
                          duration: Duration(milliseconds: 300));
                      Navigator.pop(context);
                    },
                  ),
                ))
                    .toList(),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child:
        ViewWrapper(desktopView: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// Tab Bar
            Container(
              height: screenHeight * 0.05,
              child: CustomTabBar(
                  controller: tabController,
                  tabs: contentViews.map((e) => e.tab).toList()),
            ),

            /// Tab Bar View
            Container(
              height: screenHeight * 0.8,
              child: TabControllerHandler(
                tabController: tabController,
                child: TabBarView(
                  controller: tabController,
                  children: contentViews.map((e) => e.content).toList(),
                ),
              ),
            ),

            /// Bottom Bar
            BottomBar()


          ],
        ), mobileView: Padding(
          padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
          child: Container(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    iconSize: screenWidth * 0.08,
                    icon: Icon(Icons.menu_rounded),
                    color: Colors.white,
                    splashColor: Colors.transparent,
                    onPressed: () => scaffoldKey.currentState?.openEndDrawer()),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    scrollDirection: Axis.vertical,
                    itemScrollController: itemScrollController,
                    itemCount: contentViews.length,
                    itemBuilder: (context, index) => contentViews[index].content,
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }


}
