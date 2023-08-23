import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel/Core/WardenDashboard/warden_dashboard.dart';

import '../../AdminDashboard/admin_dashboard.dart';
import '../../MentorDashboard/mentor_dashboard.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xff111111),
          ),
          height: 180.h,
          width: double.infinity,
          child: Center(
            child: Text('Hostel Leave \nManagement',
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  color: Colors.white,
                )),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.admin_panel_settings),
          title: Text(
            'Mentor Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
          onTap: () {
            // Go to MentorScreen()
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MentorScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            'Warden Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WardenScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            'Admin Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
