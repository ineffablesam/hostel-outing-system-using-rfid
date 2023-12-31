import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel/Core/HostelDashboard/Components/side_drawer.dart';

import 'Components/HostelListTile.dart';
import 'HostelLeavePage/leave_mainpage.dart';

class HostelDashboardPage extends StatelessWidget {
  const HostelDashboardPage({super.key});
  // 1375fc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: SideDrawer(),
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: Offset(0, -10),
        child: FloatingActionButton.extended(
          onPressed: () {
            HapticFeedback.heavyImpact();
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => HostelLeaveRequestsPage()),
            );
          },
          label: Text(
            "Apply Leave",
            style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          backgroundColor: Color(0xFF004bff),
          elevation: 0,
          icon: Icon(
            Icons.add,
            size: 23.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: FadeIn(
              child: Text(
                "Hostel Dashboard",
                style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ),
            centerTitle: true,
            toolbarHeight: 58.h,
            automaticallyImplyLeading: false,
            expandedHeight: 150.h,
            elevation: 0,
            pinned: true,
            backgroundColor: const Color(0xFF004bff),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              stretchModes: [
                StretchMode.fadeTitle,
              ],
              background: Container(
                padding: EdgeInsets.only(
                  top: 30.h,
                ),
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //     opacity: 0.2,
                    //     fit: BoxFit.cover,
                    //     filterQuality: FilterQuality.high,
                    //     image: AssetImage(
                    //         "assets/lottie_animations/footer_pattern.png")),
                    // color: primaryColor,
                    gradient: LinearGradient(
                        colors: [Color(0xff103cc9), Color(0xff103cc9)])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    40.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Satyanand",
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffe7f3fd),
                                ),
                              ),
                              Text(
                                "21BCE7615",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xb2ffffff),
                                ),
                              ),
                              Text(
                                'MH-4 Block',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 34.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 31.r,
                              backgroundImage: const AssetImage(
                                "assets/images/satyanand.png",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildGridItem("Total Leave", Colors.red[100]!,
                          Icons.android, context),
                      _buildGridItem("Late Come\'s", Colors.green[100]!,
                          Icons.ac_unit, context),
                      _buildGridItem("On-Time", Colors.blue[100]!,
                          Icons.access_alarm, context),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.h, top: 7.h, bottom: 7.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff111111),
                      borderRadius: BorderRadius.circular(19.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: Offset(0, 4),
                          blurRadius: 47,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(19.r),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff111111),
                            borderRadius: BorderRadius.circular(19.r),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                offset: Offset(0, 4),
                                blurRadius: 47,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              HostelCustomListTile(
                                Logovisible: true,
                                visible: true,
                                onTap: () {},
                                icon: Icons.fingerprint,
                                title: 'Biometric',
                                subtitle:
                                    'Check out your Attendance information',
                                gradientColor: const [
                                  Color(0xffFC466B),
                                  Color(0xff3F5EFB)
                                ],
                              ),
                              HostelCustomListTile(
                                Logovisible: true,
                                visible: true,
                                onTap: () {
                                  HapticFeedback.heavyImpact();
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            HostelLeaveRequestsPage()),
                                  );
                                },
                                icon: Icons.home,
                                title: 'Apply Leave',
                                subtitle: 'Apply Leave Requests',
                                gradientColor: const [
                                  Color(0xff00d2ff),
                                  Color(0xff3a47d5)
                                ],
                              ),
                              HostelCustomListTile(
                                Logovisible: true,
                                visible: true,
                                onTap: () {},
                                icon: Icons.emoji_food_beverage_outlined,
                                title: 'Mess',
                                subtitle: 'Information About your Hostel Mess',
                                gradientColor: const [
                                  Color(0xffefd5ff),
                                  Color(0xff515ada)
                                ],
                              ),
                              HostelCustomListTile(
                                Logovisible: true,
                                visible: true,
                                onTap: () {},
                                icon: Icons.info,
                                title: 'My Info Centre',
                                subtitle: 'More Information about your Hostel',
                                gradientColor: const [
                                  Color(0xffd53369),
                                  Color(0xffdaae51)
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, Color iconcolor, IconData icon, context) {
    return Material(
      color: Color(0xff111111),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Color(0xff252525),
                width: 0.7.w,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '0',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff1375fc),
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
