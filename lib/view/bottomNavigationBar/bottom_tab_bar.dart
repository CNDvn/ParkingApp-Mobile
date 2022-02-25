import 'package:flutter/material.dart';
import 'package:parkingappmobile/configs/themes/app_color.dart';
import 'package:parkingappmobile/constants/assets_path.dart';
import 'package:parkingappmobile/view/bottomNavigationBar/data_bottom_tab_bar.dart';
import 'package:parkingappmobile/view/google_map/google_map.dart';
import 'package:parkingappmobile/view/history/history.dart';
import 'package:parkingappmobile/view/payments/payments.dart';
import 'package:parkingappmobile/view/setting/setting.dart';
import 'package:parkingappmobile/view/userProfile/user_profile.dart';
import 'package:parkingappmobile/view_model/providers/user_profile_provider.dart';
import 'package:parkingappmobile/widgets/Drawer/drawer.dart';
import 'package:provider/provider.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentTab = 0;
  late TabController _tabController;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onTapHandler(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    UserProfileProvider userProvider =
        Provider.of<UserProfileProvider>(context);
    List<Widget> screens = [
      const GoogleMap(),
      const Payments(),
      const History(),
      const Setting()
    ];
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerDefault(),
      body: Stack(children: [
        IndexedStack(
          children: screens,
          index: currentTab,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 28, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black87,
              ),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
            )),
            SizedBox(
              child: ClipOval(
                child: Material(
                  color: AppColor.blueBackground,
                  child: InkWell(
                    splashColor: AppColor.whiteBackground,
                    onTap: () {
                      userProvider.getProfile();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const UserProfile();
                      }));
                    },
                    child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset(AssetPath.profilePhoto)),
                  ),
                ),
              ),
            )
          ]),
        ),
      ]),
      floatingActionButton: ActionButtonMid(
        currentTab: currentTab,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: windowWidth * 0.0155,
        child: SizedBox(
          height: windowHeight * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButtonStyle(
                      voidCallback: () {
                        onTapHandler(0);
                      },
                      icon: Icons.home_outlined,
                      currentTab: currentTab,
                      tab: 0),
                  IconButtonStyle(
                      voidCallback: () {
                        onTapHandler(1);
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
                        onTapHandler(2);
                      },
                      icon: Icons.history,
                      currentTab: currentTab,
                      tab: 2),
                  IconButtonStyle(
                      voidCallback: () {
                        onTapHandler(3);
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
