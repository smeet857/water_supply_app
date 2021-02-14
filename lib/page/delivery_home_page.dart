import 'package:flutter/material.dart';
import 'package:water_supply_app/model/zone_details.dart';
import 'package:water_supply_app/page/setting_page.dart';
import 'package:water_supply_app/repo/get_user_data_repo.dart';
import 'package:water_supply_app/repo/zone_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/view_function.dart';

class DeliveryHomePage extends StatefulWidget {
  @override
  _DeliveryHomePageState createState() => _DeliveryHomePageState();
}

class _DeliveryHomePageState extends State<DeliveryHomePage> {

  TextEditingController _cityController = TextEditingController();
  TextEditingController _societyController = TextEditingController();
  TextEditingController _customerController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  ZoneDetails _selectedZone;
  List<ZoneDetails> zones = [];
  bool isLoading = true;
  Widget status = loader();
  int quantity = 1;
  var _formKey = GlobalKey<FormState>();

  String selectedPayment = "Cash";

  @override
  void initState() {
    super.initState();
    _apiZone();
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
                _buildTextField("City", _cityController),
                SizedBox(height: 10,),
                _buildDropdownTextField("zone"),
                SizedBox(height: 10,),
                _buildTextField("Society", _societyController),
                SizedBox(height: 10,),
                _buildTextField("Customer", _customerController),
                SizedBox(height: 10,),
                _buildTextField("Description", _descriptionController),
                SizedBox(height: 20,),
                _buildPaymentView(),
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
            "Submit",
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
  Widget _buildPaymentView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Type", style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: RadioListTile(value: "Cash", groupValue: selectedPayment, onChanged: onRadioChanged,title: Text("Cash"),)),
            Expanded(child: RadioListTile(value: "Online", groupValue: selectedPayment, onChanged: onRadioChanged,title: Text("Online"),)),
          ],
        ),
      ],
    );
  }
  void onRadioChanged(value){
    setState(() {
      selectedPayment = value;
    });
  }
  Widget _buildTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        TextFormField(
          validator: (value) {
            switch (title) {
              case "City":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              case "Society":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              case "Customer":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              default:
                return null;
            }
          },
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
          hint: Text("Select Zone"),
          items: zones.map((e){
            return DropdownMenuItem(child:Text(e.title),value: e,);
          }).toList(),
          onChanged: onChanged,
          validator: (value){
            if(_selectedZone == null){
              return "Select Zone";
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
    setState(() {
      _selectedZone = value;
    });
  }

  void _apiZone(){
    setState(() {
      isLoading = true;
    });
    GetZoneRepo.fetchData(
        onSuccess: (object) {
          if (object.flag == 1) {
            zones = object.data;
          } else {
            errorToast(object.message);

          }
          setState(() {
            isLoading = false;
          });
        },
        onError: (error) {
          errorToast("Error on getting data");
          print("get zone data api fail === > $error");
          setState(() {
            isLoading = false;
          });
        });
  }

  void _onSubmitTap() {
    if(_formKey.currentState.validate()){

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
}
