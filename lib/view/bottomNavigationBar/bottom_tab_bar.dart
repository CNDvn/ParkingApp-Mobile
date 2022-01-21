import 'package:flutter/material.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/data_bottom_tab_bar.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: ActionButtonMid(currentTab: currentTab,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButtonStyle(
                      voidCallback: () {
                        setState(() {
                          currentScreen = screens[0];
                          currentTab = 0;
                        });
                      },
                      icon: Icons.home_outlined,
                      currentTab: currentTab,
                      tab: 0),
                  IconButtonStyle(
                      voidCallback: () {
                        setState(() {
                          currentScreen = screens[1];
                          currentTab = 1;
                        });
                      },
                      icon: Icons.payment,
                      currentTab: currentTab,
                      tab: 1),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButtonStyle(
                      voidCallback: () {
                        setState(() {
                          currentScreen = screens[2];
                          currentTab = 2;
                        });
                      },
                      icon: Icons.history,
                      currentTab: currentTab,
                      tab: 2),
                  IconButtonStyle(
                      voidCallback: () {
                        setState(() {
                          currentScreen = screens[3];
                          currentTab = 3;
                        });
                      },
                      icon: Icons.settings,
                      currentTab: currentTab,
                      tab: 3),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
