import 'package:flutter/material.dart';
import 'package:water_supply_app/model/society_model.dart';
import 'package:water_supply_app/model/user.dart';
import 'package:water_supply_app/model/zone_details.dart';
import 'package:water_supply_app/repo/get_customer_by_society_repo.dart';
import 'package:water_supply_app/repo/get_customer_by_zone_repo.dart';
import 'package:water_supply_app/repo/get_order_rate_by_customer.dart';
import 'package:water_supply_app/repo/get_society_by_zone_id_repo.dart';
import 'package:water_supply_app/repo/update_user_due_amount_repo.dart';
import 'package:water_supply_app/repo/user_payment_history_repo.dart';
import 'package:water_supply_app/repo/zone_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/view_function.dart';

class DeliveryPayment extends StatefulWidget {
  // final Data data;
  //
  // const DeliveryPayment({Key key, this.data}) : super(key: key);
  @override
  _DeliveryPaymentState createState() => _DeliveryPaymentState();
}

class _DeliveryPaymentState extends State<DeliveryPayment> {

  TextEditingController _dueController = TextEditingController();
  TextEditingController _payController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();


  ZoneDetails _selectedZone;
  User selectedCustomer;
  SocietyModel selectedSociety;
  String selectedPaymentType;


  List<ZoneDetails> zones = [];
  List<SocietyModel> societyList = [];
  List<User> customers = [];
  List<String> paymentType = [
    "Cash",
    "Cheque",
    "Paytm",
    "GPay",
    "Phonepe",
    "Internet Banking",
    "Other"
  ];

  bool isLoading = true;
  Widget status = loader();

  @override
  void initState() {
    _dueController.text = "0";
    _payController.text = "0";
    _apiZone();
    super.initState();
  }

  @override
  void dispose() {
    _dueController.dispose();
    _payController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(isLoading) return status;
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
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                _buildDropdownTextField("Zones"),
                SizedBox(height: 10,),
                _buildDropdownTextField("Society"),
                SizedBox(height: 10,),
                _buildDropdownTextField("Customer"),
                SizedBox(height: 10,),
                customerDetails(),
                SizedBox(height: 10,),
                _buildDropdownTextField("Payment Type"),
                SizedBox(height: 10,),
                _buildTextField("Due Amount", _dueController),
                SizedBox(height: 10,),
                _buildTextField("Pay Amount", _payController),
                SizedBox(height: 10,),
                _buildTextField("Description", _descriptionController),
              ],
            ),
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
          validator: (value){
            switch(title){
              case 'Due Amount':
                if(value.isEmpty){
                  return "Required due amount";
                }
                return null;
              case 'Pay Amount':
                if(value.isEmpty){
                  return "Required pay amount";
                }
                return null;
              default:
                return null;
            }
          },
          enabled: title == "Due Amount" ? false : true,
          controller: controller,
          cursorColor: Mycolor.accent,
          keyboardType: title == "Description" ? TextInputType.text : TextInputType.number,
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

  Widget customerDetails() {
    return Visibility(
      visible: selectedCustomer != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Details",
            style:
            TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Mycolor.accent)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Address",
                          style: TextStyle(color: Mycolor.accent, fontSize: 15),
                        )),
                    Expanded(
                        child: Text(
                          ":",
                          style: TextStyle(color: Mycolor.accent, fontSize: 15,fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 4,
                        child: Text(
                          selectedCustomer == null ? "" : selectedCustomer.address1,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Mobile No",
                          style: TextStyle(color: Mycolor.accent, fontSize: 15),
                        )),
                    Expanded(

                        child: Text(
                          ":",
                          style: TextStyle(color: Mycolor.accent, fontSize: 15,fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 4,
                        child: Text(
                          selectedCustomer == null ? "" : selectedCustomer.phone,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdownTextField(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        DropdownButtonFormField(
          value: title == "Zones" ? _selectedZone : title == "Society" ? selectedSociety : title == "Customer" ? selectedCustomer : selectedPaymentType,
          hint: Text("Select $title"),
          items: title == "Zones" ? zones.map((e){
            return DropdownMenuItem(child:Text(e.title),value: e,);
          }).toList() :title == "Society" ? societyList.map((e){
            return DropdownMenuItem(child:Text(e.name),value: e,);
          }).toList() : title == "Customer" ? customers.map((e){
            return DropdownMenuItem(child:Text("${e.firstname} ${e.lastname}"),value: e,);
          }).toList() : paymentType.map((e){
            return DropdownMenuItem(child:Text(e),value: e,);
          }).toList(),
          onChanged: (value){
            if(title == "Zones"){
              setState(() {
                _selectedZone = value;
              });
              _apiGetSociety();
            }else if(title == "Society"){
              setState(() {
                selectedSociety = value;
              });
              _apiGetCustomer();
            }else if(title == "Customer"){
              setState(() {
                selectedCustomer = value;
                _dueController.text = selectedCustomer.dueAmount;
              });
            }else{
              setState(() {
                selectedPaymentType = value;
              });
            }
          },
          validator: (value){
            if(title == "Zones"){
              if(value == null){
                return "Select Zone";
              }
            }else if(title == "Society"){
              if(value == null){
                return "Select Society";
              }
            }else if(title == "Customer"){
              if(value == null || value == ""){
                return "Select Customer";
              }
            }else{
              if(value == null || value == ""){
                return "Select Payment Type";
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

  void _apiGetCustomer(){
    customers.clear();
    selectedCustomer = null;
    showProgress(context);

    GetCustomerBySocietyRepo.fetchData(
        society_id: selectedSociety.id,
        onSuccess: (object) {
          if (object.data != {}) {
            customers = List.from(object.data);
            customers = customers.where((element) => element.roleId == roleUser).toList();
            setState(() {});
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
  void _apiGetSociety(){
    societyList.clear();
    selectedSociety = null;
    customers.clear();
    selectedCustomer = null;
    _dueController.text = "0";
    showProgress(context);

    GetSocietyByZoneIdRepo.fetchData(
        zoneId: _selectedZone.id,
        onSuccess: (object) {
          Navigator.pop(context);
          if (object.data != null) {
            societyList = List.from(object.data);
            if(societyList.isEmpty){
              errorToast("No Society Data");
            }
            setState(() {});
          } else {
            errorToast("Something went wrong on getting society");
          }
        },
        onError: (error) {
          Navigator.pop(context);
          print("get society data api fail === > $error");
        });
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

  void _onSubmitTap() {
    if(_formkey.currentState.validate()){
      _apiUpdatePayment();
    }
  }

  void _apiUpdatePayment(){
    showProgress(context);

    UpdateUserDueAmountRepo.fetchData(
        buyerId: selectedCustomer.id,
        payAmount: _payController.text,
        paymentMode: selectedPaymentType,
        paymentNote: _descriptionController.text,
        onSuccess: (object) {
          Navigator.pop(context);
          if (object.flag == 1) {
            toast(object.message);
            Navigator.pop(context);
          } else {
            errorToast(object.message);
          }
        },
        onError: (error) {
          Navigator.pop(context);
          errorToast("Error on update payment");
          print("update due payment api fail === > $error");
        },);
  }
}
