import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Objects/fetch_leave_requests_object.dart';

const base_url = "https://testapi.vitap.app";

class LeaveRequest extends ChangeNotifier {
  String? _regNo;
  String? _fromDate;
  String? _toDate;
  String? _reason;
  String? _leaveType;
  String? _place;
  String? _messType;
  bool _isLoading = false;
  String? _errorMessage;

  String? get regNo => _regNo;
  String? get fromDate => _fromDate;
  String? get toDate => _toDate;
  String? get reason => _reason;
  String? get leaveType => _leaveType;
  String? get place => _place;
  String? get messType => _messType;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  setRegNo(String value) {
    _regNo = value;
    notifyListeners();
  }

  setMessType(String value) {
    _messType = value;
    notifyListeners();
  }

  setFromDate(String value) {
    _fromDate = value;
    notifyListeners();
  }

  setToDate(String value) {
    _toDate = value;
    notifyListeners();
  }

  setReason(String value) {
    _reason = value;
    notifyListeners();
  }

  setLeaveType(String value) {
    _leaveType = value;
    notifyListeners();
  }

  setPlace(String value) {
    _place = value;
    notifyListeners();
  }

  Future<void> applyLeave(BuildContext context, String regNo) async {
    final url = '$base_url/api/uploadform';
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'regNo': regNo,
      'fromDate': _fromDate,
      'toDate': _toDate,
      'reason': _reason,
      "place": _place,
      'leaveCategory': _leaveType,
      'messCategory': _messType,
    });
    print(body);
    try {
      _isLoading = true;
      notifyListeners();
      _errorMessage = null;
      notifyListeners();

      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        showSnackBar(context, 'Leave Request Submitted Successfully');
        // Close the dialog
        Navigator.of(context).pop();
        print(responseData);
      } else {
        print(responseData);
        // Handle error response
        // error(responseData['message']);
        _errorMessage = responseData['message'];
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
      _errorMessage = error.toString();
      notifyListeners();
      throw error;
    }
  }

  List<FetchLeaveRequestData> _leaveData = [];
  List<FetchLeaveRequestData> get leaveData => _leaveData;

  Future<void> fetchLeaveData(String? regNo) async {
    final url = '$base_url/api/fetchAllLeaves?regNo=$regNo';
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        _leaveData = List.from(responseData)
            .map((json) => FetchLeaveRequestData.fromJson(json))
            .toList();
        notifyListeners();
      } else {
        // Handle error response
        _errorMessage = responseData['message'];
        notifyListeners();
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
      print(error);
      throw error;
    }
  }

  // Helper function to show a SnackBar
  void showSnackBar(BuildContext ctx, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
    // Assuming you have access to the ScaffoldState, you can use ScaffoldMessenger to show the SnackBar
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }

  Future<void> refreshData(String regNo) async {
    await fetchLeaveData(regNo);
  }
}
