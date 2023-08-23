import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../Objects/fetch_leave_requests_object.dart';

class LeaveOverviewPage extends StatelessWidget {
  final FetchLeaveRequestData leaveData;
  const LeaveOverviewPage({Key? key, required this.leaveData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> statuses = [
      "Leave applied successfully",
      "Approved by mentor",
      "Approved by warden",
      "Your leave has been approved",
      "Left campus",
      "Returned to campus",
    ];

    Map<String, int> statusIndices = {
      "Leave applied successfully": 0,
      "Approved by mentor": 1,
      "Approved by warden": 2,
      "Your leave has been approved": 3,
      "Left campus": 4,
      "Returned to campus": 5,
    };

    Map<String, Color> statusColors = {
      "Leave applied successfully": Colors.grey,
      "Approved by mentor": Colors.grey,
      "Approved by warden": Colors.grey,
      "Your leave has been approved": Colors.grey,
      "Left campus": Colors.grey,
      "Returned to campus": Colors.grey,
      "Your leave has been rejected": Colors.red,
      "Rejected by mentor": Colors.red,
      "Rejected by warden": Colors.red,
    };

    // Find the index of the current leave status
    int? statusIndex = statusIndices[leaveData.leaveStatus!];
    if (leaveData.leaveStatus == "Rejected by warden") {
      statuses[3] = "Your leave has been rejected";
      statusIndices["Your leave has been rejected"] = 3;
      statusIndex = 3;
      statuses[2] = "Rejected by warden";
      statusIndices["Rejected by warden"] = 3;
      statusColors["Rejected by warden"] = Colors.red;
    } else if (leaveData.leaveStatus == "Rejected by mentor") {
      statuses[1] = "Rejected by mentor";
      statusIndices["Rejected by mentor"] = 1;
      statuses[2] = "Approval from Warden (On-Hold)";
      statusIndex = 1;
      statuses[3] = "Your leave has been rejected";
      statusIndices["Your leave has been rejected"] = 3;
      statusColors["Rejected by mentor"] = Colors.red;
    } else if (leaveData.leaveStatus == "Approved by mentor") {
      statuses[1] = "Approved by mentor";
      statusIndices["Approved by mentor"] = 1;
      statusIndex = 1;
      statusColors["Approved by mentor"] = Colors.green;
    } else if (leaveData.leaveStatus == "Approved by warden") {
      statuses[2] = "Approved by warden";
      statusIndices["Approved by warden"] = 2;
      statusIndex = 3;
      statusColors["Approved by warden"] = Colors.green;
      statuses[3] = "Your leave has been Approved";
      statusIndices["Your leave has been Approved"] = 3;
    }

// Update the status colors based on the status index
    for (int i = 0; i <= statusIndex!; i++) {
      statusColors[statuses[i]] =
          statusColors[statuses[i]] == Colors.grey ? Colors.green : Colors.red;
    }

// Update the colors for the remaining statuses
    for (int i = statusIndex + 1; i < statuses.length; i++) {
      statusColors[statuses[i]] = Colors.grey;
    }

// Generate a list of booleans indicating which statuses are completed
    List<bool> completedStatuses =
        List.generate(statuses.length, (index) => index <= statusIndex!);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: FadeIn(
              child: Text(
                leaveData.fromDate?.substring(0, 17) ?? "",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.h, horizontal: 12.w),
                      child: Row(
                        children: [
                          Text(
                            "Status Tracker",
                            style: GoogleFonts.inter(
                                fontSize: 19.sp, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    _statusTrackerWidget(
                        statuses: statuses,
                        statusColors: statusColors,
                        completedStatuses: completedStatuses),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 1.h, horizontal: 17.w),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "Overview",
                    //         style: GoogleFonts.inter(
                    //             fontSize: 19.sp, fontWeight: FontWeight.w800),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    _buildOverviewWidget(leaveData: leaveData),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class _buildOverviewWidget extends StatelessWidget {
  const _buildOverviewWidget({
    super.key,
    required this.leaveData,
  });

  final FetchLeaveRequestData leaveData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.h, right: 25.h, bottom: 25.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Created Date",
            style:
                GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w300),
          ),
          Text(
            leaveData.createdAt ?? "",
            style:
                GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Type",
            style:
                GoogleFonts.inter(fontSize: 17.sp, fontWeight: FontWeight.w300),
          ),
          Text(
            leaveData.leaveCategory?.toUpperCase() ?? "",
            style: GoogleFonts.inter(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Duration",
            style: GoogleFonts.inter(
              fontSize: 17.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "${leaveData.fromDate?.substring(5, 16)} - ${leaveData.toDate?.substring(5, 16)}",
            style: GoogleFonts.inter(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Status",
            style: GoogleFonts.inter(
              fontSize: 17.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            (leaveData.leaveStatus == "Returned to campus")
                ? "Closed"
                : "Opened",
            style: GoogleFonts.inter(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: (leaveData.leaveStatus == "Returned to campus")
                    ? Colors.redAccent
                    : Colors.green),
          ),
        ],
      ),
    );
  }
}

class _statusTrackerWidget extends StatelessWidget {
  const _statusTrackerWidget({
    required this.statuses,
    required this.statusColors,
    required this.completedStatuses,
  });

  final List<String> statuses;
  final Map<String, Color> statusColors;
  final List<bool> completedStatuses;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: statuses.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Color indicatorColor = statusColors[statuses[index]]!;
            Color lineColor = statusColors[statuses[index]]!;

            TextStyle textStyle = GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            );

            if (completedStatuses[index]) {
              indicatorColor = Colors.green;
              lineColor = Colors.green;
            }
            if (statuses[index] == "Your leave has been rejected") {
              indicatorColor = Colors.red;
              lineColor = Colors.red;
              textStyle = GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.red,
              );
            }
            if (statuses[index] != "Your leave has been rejected" &&
                statusColors[statuses[index]] == Colors.grey) {
              textStyle = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              );
            }
            if (statuses[index] == "Rejected by mentor" ||
                statuses[index] == "Rejected by warden") {
              textStyle = GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.red,
              );
            }
            return Column(
              children: [
                TimelineTile(
                  alignment: TimelineAlign.start,
                  isFirst: index == 0,
                  isLast: index == statuses.length - 1,
                  axis: TimelineAxis.vertical,
                  indicatorStyle: IndicatorStyle(
                    width: 20.r,
                    color: indicatorColor,
                  ),
                  beforeLineStyle: LineStyle(
                    color: lineColor,
                    thickness: 2.w,
                  ),
                  endChild: Container(
                    constraints: BoxConstraints(
                      minHeight: 20.h,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 13.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(statuses[index], style: textStyle),
                          Text("Time : MM/dd/yyyy hh:mm",
                              style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
