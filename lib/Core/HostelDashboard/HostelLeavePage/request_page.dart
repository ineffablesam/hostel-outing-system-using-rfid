import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel/Core/CustomTap/custom_tap.dart';
import 'package:provider/provider.dart';

import '../../CustomDatePicker/custom_date_picker.dart';
import '../../Providers/hostel_leave_provider.dart';

class LeaveFormPopUP extends StatefulWidget {
  LeaveFormPopUP({Key? key}) : super(key: key);

  @override
  State<LeaveFormPopUP> createState() => _LeaveFormPopUPState();
}

class _LeaveFormPopUPState extends State<LeaveFormPopUP> {
  final _formKey = GlobalKey<FormState>();
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LeaveRequest>(
        create: (context) => LeaveRequest(),
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
                bottomNavigationBar: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15.h, 0, 10.h),
                    child: CustomTap(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Use null-aware operator and provide a default value.
                          Provider.of<LeaveRequest>(context, listen: false)
                              .applyLeave("21BCE8427");
                        }
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Center(
                          child: Text(
                            Provider.of<LeaveRequest>(context).isLoading
                                ? 'Applying...'
                                : 'Apply Leave',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    centerTitle: true,
                    elevation: 0,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.w, top: 17.h),
                        child: Text(
                          'Close',
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    title: FadeIn(
                      child: Text(
                        'New Leave',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   margin: EdgeInsets.all(10),
                                  //   padding: EdgeInsets.all(10.h),
                                  //   width: double.infinity,
                                  //   height: 99.h,
                                  //   decoration: BoxDecoration(
                                  //     color:
                                  //         Theme.of(context).cardHighlightColor,
                                  //     // based on the theme change the color
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Color.fromRGBO(0, 0, 0, 0.05),
                                  //         offset: Offset(0, 4),
                                  //         blurRadius: 47,
                                  //         spreadRadius: 20,
                                  //       ),
                                  //     ],
                                  //     borderRadius: BorderRadius.circular(7.r),
                                  //   ),
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         "Note",
                                  //         style: GoogleFonts.inter(
                                  //             fontSize: 16.sp,
                                  //             fontWeight: FontWeight.w700),
                                  //       ),
                                  //       Text(
                                  //         "1. You may apply for only 1 Leave request per day",
                                  //         style: GoogleFonts.inter(
                                  //             fontSize: 14.sp,
                                  //             fontWeight: FontWeight.w400),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                  Consumer<LeaveRequest>(
                                    builder: (context, leaveRequest, child) {
                                      if (leaveRequest.errorMessage != null) {
                                        WidgetsBinding.instance!
                                            .addPostFrameCallback((_) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                'Error',
                                                style: GoogleFonts.inter(
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              content: Text(
                                                leaveRequest.errorMessage!,
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // pop the dialog
                                                    Navigator.of(context)
                                                        .pop(); // pop the current page
                                                  },
                                                  child: Text('Dismiss'),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                      } else if (leaveRequest.isLoading) {
                                        return CircularProgressIndicator();
                                      } else {
                                        return Center(
                                            child: Row(
                                          children: [
                                            // Text(
                                            //   'API Status',
                                            //   style: GoogleFonts.poppins(
                                            //       color: Colors.green),
                                            // ),
                                            // CircleAvatar(
                                            //   radius: 9.r,
                                            //   backgroundColor: Colors.green,
                                            // )
                                          ],
                                        ));
                                      }
                                      return SizedBox
                                          .shrink(); // Return empty widget to avoid errors
                                    },
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  DatePickerWidget(
                                    label: 'From Date',
                                    onChanged: (date) =>
                                        Provider.of<LeaveRequest>(context,
                                                listen: false)
                                            .setFromDate(date.toString()),
                                  ),
                                  DatePickerWidget(
                                    label: 'To Date',
                                    onChanged: (date) =>
                                        Provider.of<LeaveRequest>(context,
                                                listen: false)
                                            .setToDate(date.toString()),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.h, vertical: 8.h),
                                    child: Text(
                                      "Leave Type",
                                      style: GoogleFonts.inter(
                                          fontSize: 13.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3.h, horizontal: 8.h),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: DropdownButtonFormField<String>(
                                        value: null,
                                        hint: Text("Select Leave Type"),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.r)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.r)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.r)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          fillColor: Colors.white54,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select a leave type';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          Provider.of<LeaveRequest>(context,
                                                  listen: false)
                                              .setLeaveType(value!);
                                        },
                                        items: <String>[
                                          'Casual',
                                          'Medical',
                                          'Urgent'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.h, vertical: 8.h),
                                    child: Text(
                                      "Mess Type",
                                      style: GoogleFonts.inter(
                                          fontSize: 13.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3.h, horizontal: 8.h),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: DropdownButtonFormField<String>(
                                        value: null,
                                        hint: Text("Select Mess"),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(20.0),
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.r)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.r)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.r)),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          fillColor: Colors.white54,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select a Mess type';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          Provider.of<LeaveRequest>(context,
                                                  listen: false)
                                              .setMessType(value!);
                                        },
                                        items: <String>[
                                          'Non-Veg',
                                          'Veg',
                                          'Special'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.h, vertical: 8.h),
                                    child: Text(
                                      "To Location",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            focusColor:
                                                Theme.of(context).primaryColor,
                                            contentPadding:
                                                EdgeInsets.all(20.0),
                                            hintText: 'Place',
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7.r)),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7.r)),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(0.r),
                                                  bottomLeft:
                                                      Radius.circular(0.r),
                                                  topRight:
                                                      Radius.circular(7.r),
                                                  topLeft:
                                                      Radius.circular(7.r)),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .cardColor
                                                      .withOpacity(0)),
                                            ),
                                            fillColor: Colors.white54,
                                          ),
                                          // maxLines: 10,
                                          validator: (value) {
                                            if (value?.isEmpty ?? true) {
                                              return 'Please enter the place for leave';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            Provider.of<LeaveRequest>(context,
                                                    listen: false)
                                                .setPlace(value);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.h, vertical: 8.h),
                                    child: Text(
                                      "Reason for Applying Leave",
                                      style: GoogleFonts.inter(
                                          fontSize: 13.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            focusColor:
                                                Theme.of(context).primaryColor,
                                            contentPadding:
                                                EdgeInsets.all(20.0),
                                            hintText: 'Reason',
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7.r)),
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7.r)),
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(0.r),
                                                  bottomLeft:
                                                      Radius.circular(0.r),
                                                  topRight:
                                                      Radius.circular(7.r),
                                                  topLeft:
                                                      Radius.circular(7.r)),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .cardColor
                                                      .withOpacity(0)),
                                            ),
                                            fillColor: Colors.white54,
                                          ),
                                          // maxLines: 10,
                                          validator: (value) {
                                            if (value?.isEmpty ?? true) {
                                              return 'Please enter the reason for leave';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            Provider.of<LeaveRequest>(context,
                                                    listen: false)
                                                .setReason(value);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 16.0),
                                ]),
                          )))
                ])),
          );
        });
  }
}
