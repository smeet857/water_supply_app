import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:water_supply_app/calendar/meeting.dart';
import 'package:water_supply_app/calendar/meeting_data_source.dart';
import 'package:water_supply_app/model/orders_delivery.dart';
import 'package:water_supply_app/page/order_details_page.dart';
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
  var meetings = <Meeting>[];
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
    if (isLoading) return status;
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.firstname} ${user.lastname}"),
        titleSpacing: 0,
      ),
      body: Container(
        child: SfCalendar(
          onTap: (details){
            if(details.targetElement == CalendarElement.appointment){
              var od = _getOrderDeliveryFromArray(details.appointments.first.from);
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsPage(orderDelivery: od,)));
            }
          },
          view: CalendarView.month,
          appointmentBuilder: (c,cad){
            var od = _getOrderDeliveryFromArray(cad.appointments.first.from);
            var m = cad.appointments.first;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: m.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product : ${od.serviceName}       Quantity : ${od.qtyOrdered}",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text("Total Amount : ${od.totalAmount}",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)
                ],
              ),
            );
          },
          dataSource: MeetingDataSource(meetings),
          monthViewSettings: MonthViewSettings(
              showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator),
        ),
      ),
    );
  }

  void _apiOrder() {
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
              ord.orderDelivery.forEach((delivery) {
                print("date : ${delivery.deliveryDate}");
                print("total amount : ${delivery.totalAmount}");
                print("quantity order : ${delivery.qtyOrdered}");
                delivery.serviceName = ord.service.title;
                deliverOrder.add(delivery);
                meetings.add(Meeting(
                    delivery.serviceName,
                    DateTime.parse(delivery.deliveryDate),
                    DateTime.parse(delivery.deliveryDate),
                    ord.serviceId == "1" ? Colors.red : Colors.green,
                    false, delivery.orderId
                ));
              });
              // deliverOrder.addAll(ord.orderDelivery);
            });

            setState(() {
              isLoading = false;
            });
          } else {
            errorToast(object.message);
            setState(() {
              status = errorView(callBack: () {
                _apiOrder();
              });
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
  OrderDelivery _getOrderDeliveryFromArray(DateTime date){
    OrderDelivery orderDelivery;
    for(int i =0 ;i< deliverOrder.length ; i++){
      var _date = DateFormat("yyyy-MM-dd").format(date);
      if(_date == deliverOrder[i].deliveryDate){
        orderDelivery = deliverOrder[i];
        break;
      }
    }
    return orderDelivery;
  }
}
