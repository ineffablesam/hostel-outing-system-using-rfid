// class LeaveListPage extends StatefulWidget {
//   final Profile? profile;
//
//   const LeaveListPage({Key? key, this.profile}) : super(key: key);
//
//   @override
//   _LeaveListPageState createState() => _LeaveListPageState();
// }
//
// class _LeaveListPageState extends State<LeaveListPage> {
//   late final LeaveRequest _leaveRequest;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leave List'),
//       ),
//       body: Provider<LeaveRequest>(
//         create: (_) => LeaveRequest(),
//         // Use the `builder` parameter to obtain a new `BuildContext`
//         builder: (context, child) {
//           _leaveRequest = context.watch<LeaveRequest>();
//           _leaveRequest.fetchLeaveData(widget.profile!.regNo!);
//           return Consumer<LeaveRequest>(
//             builder: (context, leaveRequest, _) {
//               if (leaveRequest.isLoading) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (leaveRequest.errorMessage != null) {
//                 return Center(
//                   child: Text(leaveRequest.errorMessage!),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: leaveRequest.leaveData.length,
//                   itemBuilder: (context, index) {
//                     final leave = leaveRequest.leaveData[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text(
//                             'From: ${leave.fromDate} - To: ${leave.toDate}'),
//                         subtitle: Text(leave.reason ?? ''),
//                         trailing: Text(leave.leaveStatus ?? ''),
//                       ),
//                     );
//                   },
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
