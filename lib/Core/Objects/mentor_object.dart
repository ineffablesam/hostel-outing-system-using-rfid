class MentorObject {
  String? status;
  List<Students>? students;

  MentorObject({this.status, this.students});

  MentorObject.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Students {
  String? email;
  String? fromDate;
  String? leaveStatus;
  String? leftCampusAt;
  String? name;
  String? phone;
  String? reason;
  String? regNo;
  String? returnedCampusAt;
  String? toDate;

  Students(
      {this.email,
      this.fromDate,
      this.leaveStatus,
      this.leftCampusAt,
      this.name,
      this.phone,
      this.reason,
      this.regNo,
      this.returnedCampusAt,
      this.toDate});

  Students.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fromDate = json['fromDate'];
    leaveStatus = json['leaveStatus'];
    leftCampusAt = json['leftCampusAt'];
    name = json['name'];
    phone = json['phone'];
    reason = json['reason'];
    regNo = json['regNo'];
    returnedCampusAt = json['returnedCampusAt'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fromDate'] = this.fromDate;
    data['leaveStatus'] = this.leaveStatus;
    data['leftCampusAt'] = this.leftCampusAt;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['reason'] = this.reason;
    data['regNo'] = this.regNo;
    data['returnedCampusAt'] = this.returnedCampusAt;
    data['toDate'] = this.toDate;
    return data;
  }
}
