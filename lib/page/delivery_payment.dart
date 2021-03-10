import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_supply_app/model/delivered_order.dart';
import 'package:water_supply_app/repo/delivered_order_repo.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';

class DeliveryPayment extends StatefulWidget {
  final Data data;

  const DeliveryPayment({Key key, this.data}) : super(key: key);
  @override
  _DeliveryPaymentState createState() => _DeliveryPaymentState();
}

class _DeliveryPaymentState extends State<DeliveryPayment> {

  TextEditingController _dueController = TextEditingController();
  TextEditingController _payController = TextEditingController();

  @override
  void initState() {
    _dueController.text = widget.data.dueAmount;
    _payController.text = "0";

    super.initState();
  }
  @override
  void dispose() {
    _dueController.dispose();
    _payController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        titleSpacing: 0,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        child: FlatButton(
          minWidth: double.infinity,
          height: 50,
          color: Mycolor.accent,
          onPressed: _onSubmitTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "Submit",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10,),
              _buildTextField("Due Amount", _dueController),
              SizedBox(height: 10,),
              _buildTextField("Pay Amount", _payController),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        TextFormField(
          enabled: title == "Due Amount" ? false : true,
          controller: controller,
          cursorColor: Mycolor.accent,
          keyboardType: TextInputType.number,
          minLines: 1,
          maxLines: 1,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mycolor.accent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mycolor.accent)),
            focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mycolor.accent, width: 2)),
          ),
        )
      ],
    );
  }

  void _onSubmitTap() {
    if(_payController.text.isNotEmpty){
      widget.data.pay = _payController.text;
      widget.data.deliveryDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      print("data === > ${widget.data.toJson()}");
      _apiDeliveredOrder();
    }else{
      errorToast("Please enter pay amount");
    }
  }

  void _apiDeliveredOrder(){
    showProgress(context);
    DeliveredOrderRepo.fetchData(
       data: widget.data.toJson(),
        onSuccess: (object) {
          Navigator.pop(context);
          if (object.flag == 1) {
            toast(object.message);
            Navigator.pushNamedAndRemoveUntil(context, '/home_page', (route) => false);
          } else {
            errorToast(object.message);
          }
        },
        onError: (error) {
          errorToast("Something went wrong");
          Navigator.pop(context);
          print("set delivered data api fail === > $error");
        });
  }
}
