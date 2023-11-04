import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';
import '../dashboard.dart';
import '../hospitaldashboard.dart';
import '../settingsPage/settings.dart';

class DrawerWidget extends StatefulWidget {
const DrawerWidget({ Key? key }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
    int selectedIndex = 0;
  @override
  Widget build(BuildContext context){
   
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          //  padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'lib/assests/images/user.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Janet Dolittle',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'janetdolittle@mail.com',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1.5,
              color: AppColors.grey100,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedIndex == 0
                      ? AppColors.buttonColor
                      : Colors.transparent),
              child: ListTile(
                leading: SvgPicture.asset(
                  'lib/assests/icons/home.svg',
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardContent()));
                },
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedIndex == 1
                      ? AppColors.buttonColor
                      : Colors.transparent),
              child: ListTile(
                leading: SvgPicture.asset(
                  'lib/assests/icons/blog.svg',
                  color: selectedIndex == 1 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Blogs',
                  style: TextStyle(
                      color: selectedIndex == 1 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedIndex == 2
                      ? AppColors.buttonColor
                      : Colors.transparent),
              child: ListTile(
                leading: SvgPicture.asset(
                  'lib/assests/icons/hospital.svg',
                  color: selectedIndex == 2 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Hospitals',
                  style: TextStyle(
                      color: selectedIndex == 2 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HospitalDashboard()));
                },
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedIndex == 3
                      ? AppColors.buttonColor
                      : Colors.transparent),
              child: ListTile(
                leading: SvgPicture.asset(
                  'lib/assests/icons/unselected_user.svg',
                  color: selectedIndex == 3 ? Colors.white : Colors.black,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: selectedIndex == 3 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              ),
            ),
            const SizedBox(
              height: 180,
            ),
            const Divider(
              color: AppColors.grey100,
              thickness: 1.5,
            ),
            const Center(
              child: Text(
                'Mboacare',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey),
              ),
            ),
            const Center(
              child: Text(
                'v0.0.1',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.buttonColor,
                ),
              ),
            )
          ],
        ),
      );
  }
}