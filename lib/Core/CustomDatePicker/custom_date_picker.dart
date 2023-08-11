import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final ValueChanged<DateTime> onChanged;

  const DatePickerWidget({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime _selectedDate = DateTime.now();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _controller.text = DateFormat('MMMM-dd').format(_selectedDate);
      widget.onChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  hintText: 'Select date',
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.r)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.r)),
                    borderSide: BorderSide(
                        color: Theme.of(context).cardColor.withOpacity(0.8)),
                  ),
                  fillColor: Colors.white54,
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: _controller,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select ${widget.label.toLowerCase()}';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
