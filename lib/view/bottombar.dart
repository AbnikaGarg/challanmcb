import 'package:challanmcbjava/util/app_colors.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'challan.dart';
import 'profile.dart';
import 'receipt.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int tabIndex = 0;

  final pages = [
    Challan(),
    Receipt(),
    Profile(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   children: [
      //     HomePage(),
      //     Certificate(),
      //     Text('notifications'),
      //     EBattle(),
      //     Profile(),
      //   ],
      //   index: controller.tabIndex,
      // ),
      body: pages[tabIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backGround2,
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Color.fromARGB(255, 221, 218, 218)),
          ],
        ),
        child: BottomNavigationBar(
          // showSelectedLabels: false,
          //  showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(color: AppColors.maincolor, ),
          selectedItemColor: AppColors.maincolor,
          backgroundColor:AppColors.backGround2,
          elevation: 0,
          iconSize: 22,
          
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.car_crash_sharp), label: 'Challan'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_rounded), label: 'Receipt'),
            //  BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account'),
          ],
          onTap: (val) {
            setState(() {
               FocusScope.of(context).unfocus();
              tabIndex = val;
            });
          },
          currentIndex: tabIndex,
        ),
      ),
    );
  }
}
