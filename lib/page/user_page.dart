import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:water_supply_app/calendar/meeting.dart';
import 'package:water_supply_app/calendar/meeting_data_source.dart';
import 'package:water_supply_app/model/orders.dart';
import 'package:water_supply_app/page/setting_page.dart';
import 'package:water_supply_app/repo/get_user_data_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/view_function.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  List<Orders> orders = [];
  bool isLoading = true;
  Widget status = loader();
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _apiOrder();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading) return status;
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.firstname} ${user.lastname}"),
        titleSpacing: 0,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => SettingPage()
            ));
          },
          icon: Icon(Icons.settings)),
        ],
      ),
      body: Container(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          appointmentBuilder: (c,ca){

            return CircleAvatar(backgroundColor: Colors.blue,radius: 15,);
          },
          monthViewSettings: MonthViewSettings(showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      ),
    );
  }

  void _apiOrder(){
    setState(() {
      isLoading = true;
    });
    GetUserDataRepo.fetchData(
        token: user.token,
        onSuccess: (object) {
          if (object.flag == 1) {
            user = object.data;
            orders = user.history.orders;
          } else {
            errorToast(object.message);
          }
          setState(() {
            isLoading = false;
          });
        },
        onError: (error) {
          errorToast("Error on getting order");
          print("get user data api fail === > $error");
          setState(() {
            isLoading = false;
          });
        });
  }
  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
