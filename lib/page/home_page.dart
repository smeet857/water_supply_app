
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:water_supply_app/dialog/enquiry_dialog.dart';
import 'package:water_supply_app/model/content.dart';
import 'package:water_supply_app/model/services.dart';
import 'package:water_supply_app/page/delivery_home_page.dart';
import 'package:water_supply_app/page/enquiry_page.dart';
import 'package:water_supply_app/page/login_page.dart';
import 'package:water_supply_app/page/module_details_page.dart';
import 'package:water_supply_app/page/user_page.dart';
import 'package:water_supply_app/repo/content_repo.dart';
import 'package:water_supply_app/repo/services_repo.dart';
import 'package:water_supply_app/util/constants.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';
import 'package:water_supply_app/util/view_function.dart';
import 'package:water_supply_app/video_player/vlc_video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isLoading = true;
  Widget _status = loader();
  final List<Content> _contentData = [];
  final List<Services> _serviceData = [];
  String _title = "Not Login";

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      if(user != null){
        _title = "${user.firstname} ${user.lastname}";
      }
    });
    _apiContent();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading) return _status;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: _onUserTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Mycolor.accent),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  color: Mycolor.accent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _title,
                  style: TextStyle(color: Mycolor.accent, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          _buildMediaView(),
          _buildModuleView(),
          _buildEnquiryView()
        ],
      ),
    );
  }

  Widget _buildMediaView() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildMediaPage(index,_contentData[index]);
        },
        itemCount: _contentData.length,
      ),
    );
  }

  Widget _buildMediaPage(int index , Content content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:Colors.black,
        border: Border.all(color: Colors.blue,width: 2)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: VPlayer(url: content.fileUpload,)),
    );
  }

  Widget _buildModuleView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: FlatButton(
              color: Mycolor.accent,
              height: 45,
              onPressed: () {
                _onModuleTap("Mineral Water");
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Mineral Water",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: FlatButton(
              color: Mycolor.accent,
              height: 45,
              onPressed: () {
                _onModuleTap("Alkaline Water");
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Alkaline Water",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnquiryView(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: FlatButton(
        minWidth: double.infinity,
        height: 45,
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
    );
  }

  void _apiContent(){
    setState(() {
      _isLoading = true;
      _status = loader();
    });
    ContentRepo.fetchData(
        onSuccess: (response){
          if(response.flag == 1){
            _contentData.addAll(response.data);
            _apiServices();
          }
        },
        onError: (error){
          setState(() {
            _status = errorView(
                callBack: (){
                  _apiContent();
                }
            );
          });
          print("Error ====> $error");
        }
    );
  }
  void _apiServices(){
    ServicesRepo.fetchData(
        onSuccess: (response){
          if(response.flag == 1){
            _serviceData.addAll(response.data);
            setState(() {
              _isLoading = false;
            });
          }else{
            setState(() {
              _status = errorView(
                  callBack: (){
                    _apiContent();
                  }
              );
            });
          }
        },
        onError: (error){
          print("get service api error ===> $error");
          setState(() {
            _status = errorView(
                callBack: (){
                  _apiContent();
                }
            );
          });
        }
    );
  }

  void _onUserTap()async{
    if(user != null){
      if(user.roleId == roleUser){
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => UserPage()
        ));
      }else{
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => DeliveryHomePage()
        ));
      }
    }else{
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => LoginPage()
      )).then((value){
        if(value != null && value){
          setState(() {
            _title = "${user.firstname} ${user.lastname}";
          });
        }
      });
    }
  }
  void _onEnquiryTap() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => EnquiryPage()
    )).then((value){
      if(value != null && value){
        showDialog(context: context,builder: (context) => EnquiryDialog());
      }
    });
  }
  void _onModuleTap(String title){
    Services service = title == "Alkaline Water" ? _serviceData[0] : _serviceData[1];
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) => ModuleDetailsPage(title: title,service: service,)
    ));
  }
}
