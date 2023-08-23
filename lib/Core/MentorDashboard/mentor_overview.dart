import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel/Core/Objects/mentor_object.dart';
import 'package:hostel/Core/Providers/mentor_provider.dart';
import 'package:provider/provider.dart';

class MentorOverview extends StatefulWidget {
  final MentorObject mentor;
  const MentorOverview({Key? key, required this.mentor}) : super(key: key);

  @override
  State<MentorOverview> createState() => _MentorOverviewState();
}

class _MentorOverviewState extends State<MentorOverview> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MentorProvider>(
        create: (_) => MentorProvider()..fetchData(),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.black,
            title: Text(
              widget.mentor.students?.first.regNo ?? "",
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color(0xff111111),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        const _titleBuild(title: "Student Name"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.name ?? ""),
                        Divider(
                          color: Colors.grey.shade900,
                        ),
                        const _titleBuild(title: "Registration Number"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.regNo ?? ""),
                        Divider(
                          color: Colors.grey.shade900,
                        ),
                        const _titleBuild(title: "From Date"),
                        _subTitleBuild(
                            title:
                                widget.mentor.students?.first.fromDate ?? ""),
                        Divider(
                          color: Colors.grey.shade900,
                        ),
                        const _titleBuild(title: "To Date"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.toDate ?? ""),
                        Divider(
                          color: Colors.grey.shade900,
                        ),
                        const _titleBuild(title: "Phone Number"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.phone ?? ""),
                        Divider(
                          color: Colors.grey.shade900,
                        ),
                        const _titleBuild(title: "Status"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.leaveStatus ??
                                ""),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color(0xff111111),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        _titleBuild(title: "Email"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.email ?? ""),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      color: Color(0xff111111),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleBuild(title: "Reason"),
                        _subTitleBuild(
                            title: widget.mentor.students?.first.reason ?? ""),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
                // Create a Custom button with container
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
                  child: Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(7.r)),
                    child: InkWell(
                      onTap: () {
                        // Approve the leave
                        Provider.of<MentorProvider>(context, listen: false)
                            .approveLeave(
                                context,
                                widget.mentor.students?.first.regNo
                                        ?.toUpperCase() ??
                                    "21BCE8427",
                                "None");
                      },
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7.r)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Approve",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.h),
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(7.r)),
                    child: InkWell(
                      onTap: () {
                        // Approve the leave
                        Provider.of<MentorProvider>(context, listen: false)
                            .disapproveLeave(
                                context,
                                widget.mentor.students?.first.regNo
                                        ?.toUpperCase() ??
                                    "21BCE8427",
                                "Test Remark");
                      },
                      borderRadius: BorderRadius.all(Radius.circular(7.r)),
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7.r)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Reject",
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                40.verticalSpace,
              ],
            ),
          ),
        ));
  }
}

class _titleBuild extends StatelessWidget {
  final String title;
  const _titleBuild({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _subTitleBuild extends StatelessWidget {
  final String title;
  const _subTitleBuild({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Colors.grey.shade200,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
