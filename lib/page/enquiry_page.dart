import 'package:flutter/material.dart';
import 'package:water_supply_app/repo/enquiry_repo.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';

class EnquiryPage extends StatefulWidget {
  @override
  _EnquiryPageState createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _referralController = TextEditingController();
  var _formKey = GlobalKey<FormState>();



  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _referralController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enquiry"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 15,),
                _buildTextField("Name", _nameController),SizedBox(height: 15,),
                _buildTextField("Mobile No", _phoneController),SizedBox(height: 15,),
                _buildTextField("Address", _addressController),SizedBox(height: 15,),
                _buildTextField("City", _cityController),SizedBox(height: 15,),
                _buildTextField("State", _stateController),SizedBox(height: 15,),
                _buildTextField("Referral Code", _referralController),SizedBox(height: 15,),
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
          onPressed: _onEnquiryTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            "Enquiry",
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          validator: (value) {
            switch (title) {
              case "Name":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              case "Mobile No":
                if (value.isEmpty) {
                  return "Cannot be empty";
                } else if (value.length < 10) {
                  return "Mobile number is not valid";
                }
                return null;
              case "Address":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              case "City":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              case "State":
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

  void _onEnquiryTap() {
    if(_formKey.currentState.validate()){
      _apiEnquiry();
    }
  }
  void _apiEnquiry(){
    showProgress(context);
    EnquiryRepo.fetchData(
        fullName: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        referralCode: _referralController.text,
        onSuccess: (response){
          Navigator.pop(context);
          if(response.flag == 1){
            toast("Success");
            Navigator.pop(context,true);
          }
        },
        onError: (error){
          errorToast("Fail : $error");
        }
    );
  }
}
