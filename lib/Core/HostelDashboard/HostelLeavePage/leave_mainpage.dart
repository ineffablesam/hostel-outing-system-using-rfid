import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:vtop_app/Helpers/CustomTap/custom_tap.dart';
import 'package:vtop_app/Helpers/apis/theme_manager.dart';
import 'package:vtop_app/pages/HostelDashboard/HostelLeavePage/leave_overview_page.dart';
import 'package:vtop_app/pages/HostelDashboard/HostelLeavePage/request_page.dart';

import '../../../Animation/flutter_flow_icon_button.dart';
import '../../../Animation/flutter_flow_utils.dart';
import '../../../Helpers/Student/profile.dart';
import '../../../Providers/hostel_leave_provider.dart';

class HostelLeaveRequestsPage extends StatelessWidget {
  final Profile? profile;
  const HostelLeaveRequestsPage({Key? key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LeaveRequest>(
        create: (_) => LeaveRequest()..fetchLeaveData(profile?.regNo ?? ""),
        child: Consumer<LeaveRequest>(builder: (context, leaveRequest, _) {
          return RefreshIndicator(
            backgroundColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onRefresh: () => Provider.of<LeaveRequest>(context, listen: false)
                .refreshData(profile?.regNo ?? ""),
            child: Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  Consumer<LeaveRequest>(builder: (context, leaveRequest, _) {
                    return SliverAppBar(
                      toolbarHeight: 90,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      elevation: 0,
                      actions: [
                        CustomTap(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => LeaveFormPopUP(
                                  profile: profile,
                                ),
                              ),
                            ).then((value) {
                              Provider.of<LeaveRequest>(context, listen: false)
                                  .refreshData(profile?.regNo ?? "");
                            });
                          },
                          child: Container(
                            width: 42.h,
                            height: 42.h,
                            margin: EdgeInsets.symmetric(horizontal: 10.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardHighlightColor,
                              borderRadius: BorderRadius.circular(10.r),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4B7BFD), Color(0xFF174EE4)],
                                stops: [0, 0.6],
                                begin: AlignmentDirectional(1, -0.64),
                                end: AlignmentDirectional(-1, 0.64),
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                      leading: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 30,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                      title: FadeIn(
                        child: Text(
                          "Leave Request",
                          style: GoogleFonts.inter(
                              fontSize: 19.sp, fontWeight: FontWeight.w900),
                        ),
                      ),
                    );
                  }),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Consumer<LeaveRequest>(
                        builder: (context, leaveRequest, _) {
                          if (leaveRequest.isLoading) {
                            return MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Shimmer(
                                      duration: Duration(seconds: 7),
                                      interval: Duration(milliseconds: 4),
                                      color: Colors.black38,
                                      colorOpacity: 0,
                                      enabled: true,
                                      child: Container(
                                        width: double.infinity,
                                        height: 90.h,
                                        decoration: BoxDecoration(
                                            // color: Color(0xffECECEC),
                                            color: Theme.of(context)
                                                .cardHighlightColor,
                                            borderRadius:
                                                BorderRadius.circular(12.r)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (leaveRequest.errorMessage != null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.h, horizontal: 10.w),
                                  alignment: Alignment.center,
                                  color: Colors.red,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CupertinoActivityIndicator(),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  "⚠️ Error:  ",
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 9.h,
                                            ),
                                            Text(
                                              leaveRequest.errorMessage!,
                                              overflow: TextOverflow.clip,
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (leaveRequest.leaveData.isEmpty) {
                            return Center(
                              child: Text('No leave requests found.'),
                            );
                          } else {
                            // Group the leave requests by month
                            final leaveDataByMonth = groupBy(
                              leaveRequest.leaveData,
                              (leave) => DateFormat('MMMM yyyy', 'en_US')
                                  .format(DateFormat(
                                          'EEE, dd MMM yyyy HH:mm:ss z',
                                          'en_US')
                                      .parse(leave.createdAt!)),
                            );

                            // Create a list of widgets for each group
                            final leaveDataByMonthWidgets = leaveDataByMonth
                                .entries
                                .toList()
                                .reversed
                                .map((entry) {
                              final month = entry.key;
                              final leaveData = entry.value;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 16.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 3.h,
                                          width: 21.w,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          month,
                                          style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: leaveData.length,
                                      itemBuilder: (context, index) {
                                        final leave = leaveData[index];

                                        Map<String, Color> statusColors = {
                                          "Leave applied successfully":
                                              Colors.amber,
                                          "Approved by mentor": Colors.green,
                                          "Rejected by mentor": Colors.red,
                                          "Approved by warden": Colors.green,
                                          "Rejected by warden": Colors.red,
                                        };

                                        Color statusColor = statusColors[
                                                leave.leaveStatus ?? ""] ??
                                            Colors.grey;

                                        return Opacity(
                                          opacity: (leave.leaveStatus ==
                                                  "Returned to campus")
                                              ? 0.5
                                              : 1,
                                          child: CustomTap(
                                            onTap: () {
                                              Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              LeaveOverviewPage(
                                                                  leaveData:
                                                                      leave)))
                                                  .then((value) {
                                                Provider.of<LeaveRequest>(
                                                        context,
                                                        listen: false)
                                                    .refreshData(
                                                        profile?.regNo ?? "");
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(9.h),
                                              // height: 99.h,
                                              padding: EdgeInsets.all(16.h),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .cardHighlightColor,
                                                // based on the theme change the color
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.05),
                                                    offset: Offset(0, 4),
                                                    blurRadius: 47,
                                                    spreadRadius: 20,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(7.r),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        leave.createdAt
                                                                ?.substring(
                                                                    0, 17) ??
                                                            "",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 19.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                      ),
                                                      Text(
                                                        "${leave.fromDate?.substring(4, 11)} - ${leave.toDate?.substring(4, 11)}",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 10.sp,
                                                                color: Colors
                                                                    .amber,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3.h,
                                                                horizontal:
                                                                    6.w),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                            color: (leave
                                                                        .leaveStatus ==
                                                                    "Returned to campus")
                                                                ? Colors
                                                                    .redAccent
                                                                    .withOpacity(
                                                                        0.1)
                                                                : Colors.green
                                                                    .withOpacity(
                                                                        0.1)),
                                                        child: Text(
                                                          (leave.leaveStatus ==
                                                                  "Returned to campus")
                                                              ? "Expired"
                                                              : "Active",
                                                          style: GoogleFonts.inter(
                                                              fontSize: 10.sp,
                                                              color: (leave
                                                                          .leaveStatus ==
                                                                      "Returned to campus")
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  (leave.leaveStatus ==
                                                          "Returned to campus")
                                                      ? Column()
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          4.h,
                                                                      horizontal:
                                                                          6.w),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(20
                                                                              .r),
                                                                  color: (leave.leaveStatus ==
                                                                              "Returned to campus" ||
                                                                          leave.leaveStatus!.contains(
                                                                              "Rejected"))
                                                                      ? Colors
                                                                          .redAccent
                                                                          .withOpacity(
                                                                              0.1)
                                                                      : Colors
                                                                          .green
                                                                          .withOpacity(
                                                                              0.1)),
                                                              child: Text(
                                                                _getDisplayedLeaveStatus(
                                                                    leave.leaveStatus ??
                                                                        "Nill"),
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color:
                                                                        statusColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList();

                            return MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: leaveDataByMonthWidgets,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}

String _getDisplayedLeaveStatus(String status) {
  if (status == "Approved by warden") {
    return "Approved";
  } else if (status == "Rejected by mentor" || status == "Rejected by warden") {
    return "Rejected";
  } else if (status == "Leave applied successfully") {
    return "Leave Applied";
  } else {
    return status ?? "Nill";
  }
}
