import 'package:flutter/material.dart';
import 'package:water_supply_app/model/payment_history.dart';
import 'package:water_supply_app/repo/user_payment_history_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/images.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/view_function.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  bool _isLoading = true;
  Widget _status = loader();

  List<PaymentHistory> listPaymentHistory = [];

  int totalAmount = 0;
  int dueAmount = 0;

  @override
  void initState() {
    super.initState();
    apiGetPayment();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading)return _status;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text('Payment',),
          actions: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric( horizontal: 12),
              margin: EdgeInsets.only(top: 12, bottom: 12, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Mycolor.accent, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Due : $dueAmount",
                style: TextStyle(color: Mycolor.accent),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(top: 12, bottom: 12, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Mycolor.accent, width: 1),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Total : $totalAmount",
                style: TextStyle(color: Mycolor.accent),
              ),
            ),
          ],
        ),
        body: listPaymentHistory.length == 0 ? Center(
          child: Text("No Payment",style: TextStyle(color: Mycolor.accent,fontSize: 20,fontWeight: FontWeight.w500),),
        ) : ListView.builder(
          itemBuilder: (context, index) {
            return PaymentView(index, listPaymentHistory[index]);
          },
          itemCount: listPaymentHistory.length,
          physics: NeverScrollableScrollPhysics(),
        )
    );
  }

  void apiGetPayment() async {
    print("Token ====> ${user.token}");
    setState(() {
      _isLoading = true;
    });
    UserPaymentHistoryRepo.fetchData(
        buyerId: user.id,
        token: user.token,
        onSuccess: (object) {
          if (object.flag == 1) {
            totalAmount = int.parse(object.totalAmount);
            dueAmount = int.parse(object.dueAmount);
            listPaymentHistory.addAll(object.data);
          } else {
            errorToast(object.message);
          }
          setState(() {
            _isLoading = false;
          });
        },
        onError: (error) {
          errorToast("Something went Wrong");
          print("get payment data api fail === > $error");
          setState(() {});
        });
  }

}


class PaymentView extends StatelessWidget {
  final int index;
  final PaymentHistory ph;

  PaymentView(this.index, this.ph);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        top: 10,
        right: 15,
      ),
      padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Mycolor.accent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${ph.paymentReceived}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Paid",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ph.paymentReceiverName,
                  style: TextStyle(
                      color: Mycolor.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Paid On : ${formatDate(ph.createdAt, "EEE , dd yyyy")}",
                  style: TextStyle(color: Mycolor.accent,),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Notes : ${ph.notes}",
                  style: TextStyle(color: Mycolor.accent,),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                MyImage.cash,
                height: 20,
                width:20,
                color: Mycolor.accent,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "cash",
                style: TextStyle(color: Colors.white,),
              ),
            ],
          )
        ],
      ),
    );
  }
}