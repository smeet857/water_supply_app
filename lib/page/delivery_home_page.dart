import 'package:flutter/material.dart';
import 'package:water_supply_app/dialog/progress_dialog.dart';
import 'package:water_supply_app/model/delivered_order.dart';
import 'package:water_supply_app/model/services.dart';
import 'package:water_supply_app/model/user.dart';
import 'package:water_supply_app/model/zone_details.dart';
import 'package:water_supply_app/page/delivery_payment.dart';
import 'package:water_supply_app/page/payment_page.dart';
import 'package:water_supply_app/page/setting_page.dart';
import 'package:water_supply_app/repo/delivered_order_repo.dart';
import 'package:water_supply_app/repo/get_customer_by_zone_repo.dart';
import 'package:water_supply_app/repo/get_user_data_repo.dart';
import 'package:water_supply_app/repo/zone_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/view_function.dart';

class DeliveryHomePage extends StatefulWidget {
  final List<Services> services;

  const DeliveryHomePage({Key key, this.services}) : super(key: key);
  @override
  _DeliveryHomePageState createState() => _DeliveryHomePageState();
}

class _DeliveryHomePageState extends State<DeliveryHomePage> {

  TextEditingController _descriptionController = TextEditingController();

  ZoneDetails _selectedZone;
  User selectedCustomer;

  List<ZoneDetails> zones = [];
  List<User> customers = [];
  bool isLoading = true;
  Widget status = loader();
  int quantity = 1;
  var _formKey = GlobalKey<FormState>();

  String selectedService = "1";

  @override
  void initState() {
    super.initState();
    _apiZone();
  }
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading) return status;
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.firstname} ${user.lastname}"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                _buildDropdownTextField("Zones"),
                SizedBox(height: 10,),
                _buildDropdownTextField("Customer"),
                SizedBox(height: 10,),
                _buildTextField("Description", _descriptionController),
                SizedBox(height: 20,),
                _buildServiceType(),
                SizedBox(height: 10,),
                _buildProductQuantity(),
              ],
            ),
          ),
        ),
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
            "Next",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),);
  }

  Widget _buildProductQuantity(){
    return Row(
      children: [
        Text("Product Quantity", style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        Spacer(),
        FlatButton(onPressed: onMinusTap,height: 25,minWidth: 20, color: Mycolor.accent,child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
        Text("  $quantity  ", style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold,fontSize: 18),),
        FlatButton(onPressed: onPlusTap,height: 25,minWidth: 20, color: Mycolor.accent,child: Text("+",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),

      ],
    );
  }
  Widget _buildServiceType(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Service Type", style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: RadioListTile(value: "1", groupValue: selectedService, onChanged: onRadioChanged,title: Text("Alkaline Water"),)),
            Expanded(child: RadioListTile(value: "2", groupValue: selectedService, onChanged: onRadioChanged,title: Text("Mineral Water"),)),
          ],
        ),
      ],
    );
  }
  void onRadioChanged(value){
    setState(() {
      selectedService = value;
    });
  }
  Widget _buildTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        TextFormField(
          controller: controller,
          cursorColor: Mycolor.accent,
          keyboardType: title == "Mobile No" ? TextInputType.number : TextInputType.text,
          maxLength: title == "Mobile No" ? 10 : null,
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

  Widget _buildDropdownTextField(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        DropdownButtonFormField(
          value: title == "Zones" ? _selectedZone : selectedCustomer,
          hint: Text("Select $title"),
          items: title == "Zones" ? zones.map((e){
            return DropdownMenuItem(child:Text(e.title),value: e,);
          }).toList() : customers.map((e){
            return DropdownMenuItem(child:Text("${e.firstname} ${e.lastname}"),value: e,);
          }).toList(),
          onChanged: (value){
            if(title == "Zones"){
              setState(() {
                _selectedZone = value;
              });
              _apiGetCustomer();
            }else{
              setState(() {
                selectedCustomer = value;
              });
            }
          },
          validator: (value){
            if(title == "Zones"){
              if(value == null){
                return "Select Zone";
              }
            }else{
              if(value == null || value == ""){
                return "Select Customer";
              }
            }

            return null;
          },
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

  void onChanged(value){

  }

  void _apiZone(){
    setState(() {
      isLoading = true;
      status = loader();
    });
    GetZoneRepo.fetchData(
        onSuccess: (object) {
          if (object.flag == 1) {
            zones = object.data;
            setState(() {
              isLoading = false;
            });
          } else {
            errorToast(object.message);
            setState(() {
              status = errorView(
                  callBack: (){
                    _apiZone();
                  }
              );
            });
          }
        },
        onError: (error) {
          print("get zone data api fail === > $error");
          setState(() {
            status = errorView(
                callBack: (){
                  _apiZone();
                }
            );
          });
        });
  }

  void _apiGetCustomer(){
    customers.clear();
    selectedCustomer = null;
    showProgress(context);

    GetCustomerByZoneRepo.fetchData(
      zoneId: _selectedZone.id,
        onSuccess: (object) {
          if (object.data != {}) {
            customers = List.from(object.data);
            setState(() {
              isLoading = false;
            });
          } else {
            errorToast("Something went wrong on getting customers");
            setState(() {
              status = errorView(
                  callBack: (){
                    _apiGetCustomer();
                  }
              );
            });
          }
          Navigator.pop(context);
        },
        onError: (error) {
          Navigator.pop(context);
          print("get customer data api fail === > $error");
          setState(() {
            status = errorView(
                callBack: (){
                  _apiZone();
                }
            );
          });
        });
  }

  void _onSubmitTap() async{
    if(_formKey.currentState.validate()){
      var data = Data();
      data.buyerId = selectedCustomer.id;
      data.deliveryNotes = _descriptionController.text;
      data.orderId = selectedService;
      data.totalAmount = await _calculateTotalAmount();
      data.qtyOrdered = quantity.toString();
      data.dueAmount = selectedCustomer.dueAmount;

      Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPayment(data: data,)));
    }
  }

  void onMinusTap() {
    if(quantity > 1){
      setState(() {
        quantity = quantity - 1;
      });
    }
  }
  void onPlusTap() {
    setState(() {
      quantity ++;
    });
  }
  Future<String> _calculateTotalAmount()async{
    int _totalAmount = 0;

    for(int i = 0 ; i< widget.services.length ; i++){
       if(selectedService == widget.services[i].id){
         _totalAmount = int.parse(widget.services[i].price) * quantity;
         break;
       }
    }
    String str = _totalAmount.toString();
    return str;
  }
}
