import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_supply_app/dialog/progress_dialog.dart';
import 'package:water_supply_app/model/delivered_order.dart';
import 'package:water_supply_app/model/orders.dart';
import 'package:water_supply_app/model/services.dart';
import 'package:water_supply_app/model/society_model.dart';
import 'package:water_supply_app/model/user.dart';
import 'package:water_supply_app/model/zone_details.dart';
import 'package:water_supply_app/page/delivery_payment.dart';
import 'package:water_supply_app/page/payment_page.dart';
import 'package:water_supply_app/page/setting_page.dart';
import 'package:water_supply_app/repo/delivered_order_repo.dart';
import 'package:water_supply_app/repo/get_customer_by_zone_repo.dart';
import 'package:water_supply_app/repo/get_order_rate_by_customer.dart';
import 'package:water_supply_app/repo/get_society_by_zone_id_repo.dart';
import 'package:water_supply_app/repo/get_user_data_repo.dart';
import 'package:water_supply_app/repo/zone_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/view_function.dart';

import '../repo/get_customer_by_society_repo.dart';

class DeliveryHomePage extends StatefulWidget {
  final List<Services> services;

  const DeliveryHomePage({Key key, this.services}) : super(key: key);

  @override
  _DeliveryHomePageState createState() => _DeliveryHomePageState();
}

class _DeliveryHomePageState extends State<DeliveryHomePage> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _returnBottlesController = TextEditingController();

  ZoneDetails _selectedZone;
  User selectedCustomer;
  SocietyModel selectedSociety;
  DateTime selectedDate = DateTime.now();

  List<ZoneDetails> zones = [];
  List<User> customers = [];
  List<SocietyModel> societyList = [];
  List<Orders> orderList = [];
  bool isLoading = true;
  Widget status = loader();
  int quantity = 0;
  int returnBottle = 0;
  var _formKey = GlobalKey<FormState>();

  Orders selectedService;

  @override
  void initState() {
    super.initState();
    _returnBottlesController.text = "0";
    _dateController.text = DateFormat("dd-MM-yyyy").format(selectedDate);
    _apiZone();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _returnBottlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return status;
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
                SizedBox(
                  height: 10,
                ),
                _buildDropdownTextField("Zones"),
                SizedBox(
                  height: 10,
                ),
                _buildDropdownTextField("Society"),
                SizedBox(
                  height: 10,
                ),
                _buildDropdownTextField("Customer"),
                SizedBox(
                  height: 20,
                ),
                customerDetails(),
                SizedBox(
                  height: 20,
                ),
                _buildServiceType(),
                SizedBox(
                  height: 10,
                ),
                _buildProductQuantity(),
                SizedBox(
                  height: 10,
                ),
                _buildReturnBottle(),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      _showDatePicker();
                    },
                    child: _buildTextField("Select Date", _dateController)),
                SizedBox(
                  height: 20,
                ),
                _buildTextField("Description", _descriptionController),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildProductQuantity() {
    return Row(
      children: [
        Text(
          "Product Quantity",
          style: TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        FlatButton(
            onPressed: onMinusTap,
            height: 25,
            minWidth: 20,
            color: Mycolor.accent,
            child: Text(
              "-",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
        Text(
          "  $quantity  ",
          style: TextStyle(
              color: Mycolor.accent, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        FlatButton(
            onPressed: onPlusTap,
            height: 25,
            minWidth: 20,
            color: Mycolor.accent,
            child: Text(
              "+",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
      ],
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(2040),
    ).then((value) {
      setState(() {
        selectedDate = value;
        _dateController.text = DateFormat("dd-MM-yyyy").format(selectedDate);
      });
    });
  }

  Widget _buildReturnBottle() {
    return Row(
      children: [
        Text(
          "Return Bottle",
          style: TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        FlatButton(
            onPressed: onReturnBottleMinusTap,
            height: 25,
            minWidth: 20,
            color: Mycolor.accent,
            child: Text(
              "-",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
        Text(
          "  $returnBottle  ",
          style: TextStyle(
              color: Mycolor.accent, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        FlatButton(
            onPressed: onReturnBottlePlusTap,
            height: 25,
            minWidth: 20,
            color: Mycolor.accent,
            child: Text(
              "+",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
      ],
    );
  }

  Widget _buildServiceType() {
    return Visibility(
      visible: orderList.length != 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Service Type",
            style:
                TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: orderList.map((e) {
              return Expanded(
                  child: RadioListTile(
                value: e,
                groupValue: selectedService,
                onChanged: onRadioChanged,
                title: Text(e.title),
              ));
            }).toList(),
          ),
        ],
      ),
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

  void onRadioChanged(value) {
    setState(() {
      selectedService = value;
    });
  }

  Widget _buildTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (value) {
            switch (title) {
              case 'Return Bottle':
                if (value.isEmpty) {
                  return "Required Return Bottle";
                }
                return null;
              default:
                return null;
            }
          },
          controller: controller,
          enabled: title == "Select Date" ? false : true,
          cursorColor: Mycolor.accent,
          keyboardType: title == "Return Bottles"
              ? TextInputType.number
              : TextInputType.text,
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
        Text(
          title,
          style: TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          value: title == "Zones"
              ? _selectedZone
              : title == "Society"
                  ? selectedSociety
                  : selectedCustomer,
          hint: Text("Select $title"),
          items: title == "Zones"
              ? zones.map((e) {
                  return DropdownMenuItem(
                    child: Text(e.title),
                    value: e,
                  );
                }).toList()
              : title == "Society"
                  ? societyList.map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e,
                      );
                    }).toList()
                  : customers.map((e) {
                      return DropdownMenuItem(
                        child: Text("${e.firstname} ${e.lastname}"),
                        value: e,
                      );
                    }).toList(),
          onChanged: (value) {
            if (title == "Zones") {
              setState(() {
                _selectedZone = value;
              });
              _apiGetSociety();
            } else if (title == "Society") {
              setState(() {
                selectedSociety = value;
              });
              _apiGetCustomer();
            } else {
              setState(() {
                selectedCustomer = value;
              });
              _apiGetOrderRateByCustomer();
            }
          },
          validator: (value) {
            if (title == "Zones") {
              if (value == null) {
                return "Select Zone";
              }
            } else if (title == "Society") {
              if (value == null) {
                return "Select society";
              }
            } else {
              if (value == null || value == "") {
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

  void _apiZone() {
    setState(() {
      isLoading = true;
      status = loader();
    });
    GetZoneRepo.fetchData(onSuccess: (object) {
      if (object.flag == 1) {
        zones = object.data;
        if (zones.isEmpty) {
          errorToast("No Zone Data");
        }
        setState(() {
          isLoading = false;
        });
      } else {
        errorToast(object.message);
        setState(() {
          status = errorView(callBack: () {
            _apiZone();
          });
        });
      }
    }, onError: (error) {
      print("get zone data api fail === > $error");
      setState(() {
        status = errorView(callBack: () {
          _apiZone();
        });
      });
    });
  }

  void _apiGetCustomer() {
    customers.clear();
    orderList.clear();
    selectedCustomer = null;
    showProgress(context);

    GetCustomerBySocietyRepo.fetchData(
        society_id: selectedSociety.id,
        onSuccess: (object) {
          Navigator.pop(context);
          if (object.data != null) {
            customers = List.from(object.data);
            customers = customers
                .where((element) => element.roleId == roleUser)
                .toList();
            if (customers.isEmpty) {
              errorToast("No Customer Data");
            }
            setState(() {});
          } else {
            errorToast("Something went wrong on getting customers");
          }
        },
        onError: (error) {
          Navigator.pop(context);
          print("get customer data api fail === > $error");
        });
  }

  void _apiGetSociety() {
    societyList.clear();
    selectedSociety = null;
    customers.clear();
    selectedCustomer = null;
    orderList.clear();
    showProgress(context);

    GetSocietyByZoneIdRepo.fetchData(
        zoneId: _selectedZone.id,
        onSuccess: (object) {
          Navigator.pop(context);
          if (object.data != null) {
            societyList = List.from(object.data);
            if (societyList.isEmpty) {
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

  void _apiGetOrderRateByCustomer() {
    showProgress(context);
    setState(() {
      orderList.clear();
    });
    GetOrderRateByCustomerRepo.fetchData(
        userId: selectedCustomer.id,
        onSuccess: (object) {
          if (object.data != {}) {
            orderList = List.from(object.data);
            if (orderList.length == 0) {
              errorToast("No Orders of this customer");
            } else {
              selectedService = orderList[0];
            }
          } else {
            errorToast("Something went wrong on getting order");
            print("Error : ${object.message}");
          }
          Navigator.pop(context);
          setState(() {});
        },
        onError: (error) {
          Navigator.pop(context);
          print("get order data api fail === > $error");
          setState(() {});
        });
  }

  void _apiDeliveredOrder(Data data) {
    print("token ====> ${user.token}");
    print("pass date  ====> ${data.toJson()}");

    showProgress(context);
    DeliveredOrderRepo.fetchData(
        data: data.toJson(),
        onSuccess: (object) {
          Navigator.pop(context);
          if (object.flag == 1) {
            toast(object.message);
            _clearAllField();
            Navigator.pushNamedAndRemoveUntil(
                context, '/home_page', (route) => false);
          } else {
            errorToast(object.message);
          }
        },
        onError: (error) {
          errorToast("Something went wrong");
          Navigator.pop(context);
          print("delivered data api fail === > $error");
        });
  }

  void _onSubmitTap() async {
    if (quantity != 0 || returnBottle != 0) {
      if (_formKey.currentState.validate()) {
        var data = Data();
        data.buyerId = selectedCustomer.id;
        data.deliveryNotes = _descriptionController.text;
        data.orderId = selectedService.orderId;
        data.totalAmount =
            (int.parse(selectedService.price) * quantity).toString();
        data.qtyOrdered = quantity.toString();
        data.returnBottles = returnBottle.toString();
        data.dueAmount = selectedCustomer.dueAmount;
        data.pay = "0";
        data.deliveryDate = DateFormat("yyyy-MM-dd").format(selectedDate);

        _apiDeliveredOrder(data);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPayment(data: data,)));
      }
    }
  }

  void _clearAllField() {
    setState(() {
      customers.clear();
      _descriptionController.text = "";
      _returnBottlesController.text = "0";
      quantity = 1;
    });
  }

  void onMinusTap() {
    if (quantity > 1) {
      setState(() {
        quantity = quantity - 1;
      });
    }
  }

  void onReturnBottleMinusTap() {
    if (returnBottle > 0) {
      setState(() {
        returnBottle = returnBottle - 1;
      });
    }
  }

  void onPlusTap() {
    setState(() {
      quantity++;
    });
  }

  void onReturnBottlePlusTap() {
    setState(() {
      returnBottle++;
    });
  }

  Future<String> _calculateTotalAmount() async {
    int _totalAmount = 0;

    for (int i = 0; i < widget.services.length; i++) {
      if (selectedService.serviceId == widget.services[i].id) {
        _totalAmount = int.parse(widget.services[i].price) * quantity;
        break;
      }
    }
    String str = _totalAmount.toString();
    return str;
  }
}
