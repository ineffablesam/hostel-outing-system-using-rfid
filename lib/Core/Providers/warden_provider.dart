import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Objects/mentor_object.dart';

class WardenProvider with ChangeNotifier {
  List<MentorObject>? mentorData;
  bool _isLoading = false;
  bool _isError = false;

  bool get isError => _isError;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    try {
      _isLoading = true;
      notifyListeners();
      final url = Uri.https(
        'testapi.vitap.app',
        '/api/students',
        {'employeeId': '71112', 'status': '1'},
      );

      final response = await http.get(url);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = json.decode(response.body);
        mentorData = [MentorObject.fromJson(jsonData)];
        _isLoading = false;
        _isError = false;
        notifyListeners();
      } else {
        _isLoading = false;
        _isError = true;
        notifyListeners();
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      _isLoading = false;
      _isError = true;
      notifyListeners();
    }
  }

  Future<void> approveLeave(
      BuildContext ctx, String regNo, String remark) async {
    try {
      final url = Uri.https('testapi.vitap.app', '/api/updateLeaveStatus');
      final requestBody = json.encode({
        "regNo": regNo,
        "status": 2,
        "remark": remark,
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // Leave approval successful
        showSnackBar(ctx, 'Leave Approved');
      } else {
        // Leave approval failed
        showSnackBar(ctx, 'Failed to approve leave');
      }
    } catch (error) {
      // Handle network or other errors
      showSnackBar(ctx, 'Error approving leave: $error');
    }
  }

  Future<void> disapproveLeave(
      BuildContext ctx, String regNo, String remark) async {
    try {
      final url = Uri.https('testapi.vitap.app', '/api/updateLeaveStatus');
      final requestBody = json.encode({
        "regNo": regNo,
        "status": 4,
        "remark": remark,
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // Leave disapproval successful
        showSnackBar(ctx, 'Leave Disapproved');
      } else {
        // Leave disapproval failed
        showSnackBar(ctx, 'Failed to disapprove leave');
      }
    } catch (error) {
      // Handle network or other errors
      showSnackBar(ctx, 'Error disapproving leave: $error');
    }
  }

  Future<void> executeArchive(BuildContext ctx) async {
    try {
      final url = Uri.https('testapi.vitap.app', '/api/execute');
      final requestBody = json.encode({
        "action": "execute",
      });

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // Leave disapproval successful
        showSnackBar(ctx, 'Data Dumped and cleared successfully');
      } else {
        // Leave disapproval failed
        showSnackBar(ctx, 'Failed to dump data');
      }
    } catch (error) {
      // Handle network or other errors
      showSnackBar(ctx, 'Error Dumping: $error');
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
}
