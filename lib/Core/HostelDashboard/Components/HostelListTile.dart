import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostelCustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColor;
  final GestureTapCallback? onTap;
  bool visible;
  bool Logovisible;
  HostelCustomListTile({
    Key? key,
    required this.Logovisible,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColor,
    required this.onTap,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.3),
                    top: BorderSide(color: Colors.black, width: 0.3))),
            child: ListTile(
              shape: const RoundedRectangleBorder(),
              onTap: null,
              leading: Visibility(
                visible: Logovisible,
                child: Container(
                  width: 39.h,
                  height: 39.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradientColor,
                      )),
                  child: Icon(
                    icon,
                    size: 19.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 11.4.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                  // color: Colors.black
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              trailing: Visibility(
                visible: visible,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFADADAD),
                  size: 19.sp,
                ),
              ),
              tileColor: Colors.white,
              dense: false,
            ),
          ),
        ),
      ],
    );
  }
}
