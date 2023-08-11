import '../Utils/flutter_flow_utils.dart';

class FetchLeaveRequestData {
  final String? fromDate;
  final String? toDate;
  final String? leaveCategory;
  final String? leaveStatus;
  final String? leftCampusAt;
  final String? returnedCampusAt;
  final String? place;
  final String? reason;
  final String? userId;
  final String? createdAt;

  FetchLeaveRequestData({
    required this.createdAt,
    required this.fromDate,
    required this.toDate,
    required this.leaveCategory,
    required this.leaveStatus,
    required this.leftCampusAt,
    required this.returnedCampusAt,
    required this.place,
    required this.reason,
    required this.userId,
  });

  factory FetchLeaveRequestData.fromJson(Map<String, dynamic> json) {
    return FetchLeaveRequestData(
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      leaveCategory: json['leaveCategory'],
      leaveStatus: json['leaveStatus'],
      leftCampusAt: json['leftCampusAt'],
      returnedCampusAt: json['returnedCampusAt'],
      place: json['place'],
      reason: json['reason'],
      userId: json['userid'],
      createdAt: json['createdAt'],
    );
  }

  DateTime parseDate(String dateStr) {
    final DateFormat format = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz');
    return format.parse(dateStr);
  }

  DateTime get parsedFromDate => parseDate(fromDate!);
  DateTime get parsedToDate => parseDate(toDate!);
}
