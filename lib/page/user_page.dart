import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:water_supply_app/calendar/meeting.dart';
import 'package:water_supply_app/calendar/meeting_data_source.dart';
import 'package:water_supply_app/model/orders.dart';
import 'package:water_supply_app/model/orders_delivery.dart';
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

  List<OrderDelivery> deliverOrder = [];
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
      ),
      body: Container(
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      ),
    );
  }

  void _apiOrder(){
    setState(() {
      isLoading = true;
      status = loader();
    });
    GetUserDataRepo.fetchData(
        token: user.token,
        onSuccess: (object) {
          if (object.flag == 1) {
            user = object.data;
            var orders = user.history.orders;

            orders.forEach((ord) {
              var sn = ord.service.title;
              ord.orderDelivery.forEach((delivery) {
                delivery.serviceName = sn;
              });
              deliverOrder.addAll(ord.orderDelivery);
            });

            setState(() {
              isLoading = false;
            });
          } else {
            errorToast(object.message);
            setState(() {
              status = errorView(
                  callBack: (){
                    _apiOrder();
                  }
              );
            });
          }
        },
        onError: (error) {
          errorToast("Error on getting data");
          print("get user data api fail === > $error");
          setState(() {
            isLoading = false;
          });
          // setState(() {
          //   status = errorView(
          //       callBack: (){
          //         _apiOrder();
          //       }
          //   );
          // });
        });
  }
  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    // deliverOrder.forEach((element) {
    //   meetings.add(Meeting("${element.serviceName}",from, to, background, isAllDay));
    // });
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
