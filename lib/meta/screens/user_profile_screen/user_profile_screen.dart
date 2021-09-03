import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/constants.dart';

import 'package:inventory_management/app/controllers/dashboard_controller.dart';
import 'package:inventory_management/app/data/models/user_model.dart';
import 'package:inventory_management/app/data/prefs_manager.dart';
import 'package:inventory_management/meta/screens/login/login_screen.dart';
import 'package:inventory_management/meta/screens/user_profile_screen/widgets/card_item.dart';

import 'package:inventory_management/meta/widgets/app_bar.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AppPrefs appPrefs = AppPrefs();
  // UserModel _userModel;

  // loadSharedPrefs() async {
  //   try {
  //     UserModel user = await appPrefs.readUser(Constants.user_key);
  //     setState(() {
  //       _userModel = user;
  //     });
  //   } catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: new Text("Nothing found!"),
  //         duration: const Duration(milliseconds: 500)));
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   setState(() {});
  // }
  final DashBoardController _dashBoardController = Get.find();
  @override
  Widget build(BuildContext context) {
    print("http://" +
        _dashBoardController.userModel.value.data.userImage.toString());
    return Scaffold(
      appBar: appBar(
        title: "User Profile",
        leadingWidget: BackButton(
          color: Colors.white,
        ),
      ),
      backgroundColor: kPrimaryColorDark,
      body: Container(
        height: Get.size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: Get.size.height / 30,
            ),
            Card(
              elevation: 11,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: CircleAvatar(
                radius: 70,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                        placeholder: "assets/images/robert.jpeg",
                        image: "http://" +
                            _dashBoardController.userModel.value.data.userImage
                                .toString()
                    ),
                  ),
                ),
                // backgroundImage: AssetImage(),
              ),
            ),
            SizedBox(height: Get.size.height / 30),
            Card(
              margin: EdgeInsets.symmetric(horizontal: Get.size.width / 10),
              elevation: 11,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23)),
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Container(
                width: Get.size.width,
                decoration: BoxDecoration(
                    color: Color(0xffE9EDEF),
                    borderRadius: BorderRadius.circular(23)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _dashBoardController.userModel.value.data.firstName
                              .toString()
                              .capitalize +
                          " " +
                          _dashBoardController.userModel.value.data.lastName
                              .toString()
                              .capitalize,
                      style: TextStyle(
                        fontSize: 21.0,
                        color: kPrimaryColorTextDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      UserModel().getRole(_dashBoardController
                          .userModel.value.data.role
                          .toString()),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ListTile(
                    //       leading: Icon(
                    //         Icons.phone,
                    //         color: kPrimaryColorDark,
                    //       ),
                    //     ),
                    //   ],
                    // )
                    CardItem(
                      icon: Icons.phone,
                      label: "Phone Number",
                      value: _dashBoardController.userModel.value.data.phoneNo
                          .toString(),
                    ),
                    CardItem(
                      icon: Icons.access_time_outlined,
                      //   label: "Shift Time",
                      value: _dashBoardController.userModel.value.data.shiftTime
                          .toString(),
                    ),
                    CardItem(
                      icon: Icons.calendar_today,
                      //   label: "Shift Time",
                      value: _dashBoardController
                          .userModel.value.data.joinedDate
                          .toString(),
                    ),
                    // vSizedBox1,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.size.height / 50,
            ),
            TextButton(
                onPressed: () async {
                  await appPrefs.remove(Constants.user_key);

                  await Get.offAll(() => LoginScreen(),
                      curve: Curves.elasticIn, duration: Duration(seconds: 1));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    primary: kButtonColorPrimary,
                    padding:
                        EdgeInsets.symmetric(horizontal: Get.size.width / 5)))
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     profilePic(),
      //     roll(),
      //     profileInfo(),
      //     Container(
      //       // color: Colors.red,
      //       child: ElevatedButton(
      //         onPressed: () {},
      //         child: Text('LOG OUT'),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  // Padding profileInfo() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       // color: Colors.red,
  //       padding: EdgeInsets.only(left: 50),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Flexible(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     'Name',
  //                     style: TextStyle(fontSize: 19),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     'Address',
  //                     style: TextStyle(fontSize: 19),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     'Created',
  //                     style: TextStyle(fontSize: 19),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     'Joined Date',
  //                     style: TextStyle(fontSize: 19),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                     'Shift Time',
  //                     style: TextStyle(fontSize: 19),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Flexible(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                       "${_dashBoardController.userModel.value.data.firstName} ${_dashBoardController.userModel.value.data.lastName}",
  //                       style: TextStyle(fontSize: 19, color: Colors.grey)),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                       '${_dashBoardController.userModel.value.data.address} ${_dashBoardController.userModel.value.data.city}',
  //                       style: TextStyle(fontSize: 19, color: Colors.grey)),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                       _dashBoardController.userModel.value.data.tenure,
  //                       style: TextStyle(fontSize: 19, color: Colors.grey)),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                       _dashBoardController.userModel.value.data.joinedDate,
  //                       style: TextStyle(fontSize: 19, color: Colors.grey)),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text(
  //                       _dashBoardController.userModel.value.data.shiftTime,
  //                       style: TextStyle(fontSize: 19, color: Colors.grey)),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Container roll() {
    return Container(
      child: Text(_dashBoardController.userModel.value.data.role,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          )),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
    );
  }

  Padding profilePic() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      child: CircleAvatar(
        radius: 80,
        backgroundImage: AssetImage("assets/images/spider.png"),
      ),
    );
  }
}
