import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel/Core/MentorDashboard/mentor_overview.dart';
import 'package:hostel/Core/Providers/warden_provider.dart';
import 'package:provider/provider.dart';

import '../CustomTap/custom_tap.dart';
import '../Providers/mentor_provider.dart';

class WardenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<WardenProvider>(context, listen: false).fetchData();
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text('Mentor Dashboard',
            style: GoogleFonts.poppins(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Consumer<WardenProvider>(
        builder: (context, wardenProvider, child) {
          if (wardenProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (wardenProvider.mentorData == null) {
            return Center(
                child: Text('No Active Leave Requests',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )));
          } else if (wardenProvider.isError) {
            return Center(
                child: Text('No Active Leave Requests',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )));
          } else {
            return ListView.builder(
              itemCount: wardenProvider.mentorData!.length,
              itemBuilder: (context, index) {
                final mentorObject = wardenProvider.mentorData![index];
                // Build your UI using mentorObject
                return CustomTap(
                  onTap: () {
                    Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    MentorOverview(mentor: mentorObject)))
                        .then((value) {
                      Provider.of<MentorProvider>(context, listen: false)
                          .fetchData();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(9.h),
                    // height: 99.h,
                    padding: EdgeInsets.all(16.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff111111),

                      // based on the theme change the color
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: Offset(0, 4),
                          blurRadius: 47,
                          spreadRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mentorObject.students?.first.name ?? "",
                              style: GoogleFonts.inter(
                                  fontSize: 19.sp, fontWeight: FontWeight.w900),
                            ),
                            7.verticalSpace,
                            Text(
                              "${mentorObject.students?.first.regNo}" ?? "",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w400),
                            ),
                            10.verticalSpace,
                            Text(
                              "Reason: ${mentorObject.students?.first.reason}",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            10.verticalSpace,
                            Text(
                              "${mentorObject.students?.first.fromDate?.substring(5, 11)} - ${mentorObject.students?.first.toDate?.substring(4, 11)}",
                              style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w700),
                            ),
                            10.verticalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 6.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.amber.withOpacity(0.1)),
                              child: Text(
                                "Pending Approval",
                                style: GoogleFonts.inter(
                                    fontSize: 10.sp,
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
