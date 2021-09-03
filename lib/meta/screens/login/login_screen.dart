import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:inventory_management/app/constants/colors.dart';
import 'package:inventory_management/app/constants/dimentions.dart';
import 'package:inventory_management/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool hidePassord = true;
  // bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String phoneNumber;
    String password;

    Future<void> loginUser() async {
      await Provider.of<LoginProvider>(context, listen: false).loginUser(
        context: context,
        phoneNumber: int.parse(phoneNumber),
        password: password,
      );
    }

    void validateLoginForm() {
      if (formKey.currentState.validate()) {
        print("Login validated");
        formKey.currentState.save();
        print("Phone: $phoneNumber, Password: $password");
        loginUser();
      } else {
        print("Not validated");
      }
    }

    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {
    //     isLoaded = true;
    //   });
    // });

    return Consumer<LoginProvider>(
        builder: (context, model, child) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              // height: Get.height,
              width: Get.width,
              child: Stack(children: [
                SvgPicture.asset(
                  "assets/images/vssLogo.svg",
                  semanticsLabel: 'A red up arrow',
                  fit: BoxFit.contain,
                  allowDrawingOutsideViewBox: true,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height / 1.5,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width < 900
                                  ? (MediaQuery.of(context).size.width * 0.2)
                                  : (MediaQuery.of(context).size.width) * 0.3),
                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Padding(
                              padding: size.width < 900
                                  ? EdgeInsets.only(top: size.width * 0.2)
                                  : EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width *
                                          0.3),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    vSizedBox4,
                                    Spacer(
                                      flex: 2,
                                    ),
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: kPrimaryColor,
                                      onSaved: (newValue) {
                                        phoneNumber = newValue;
                                      },
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 10,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "Required!"),
                                        MinLengthValidator(10,
                                            errorText:
                                                "Enter a valid Phone Number!"),
                                      ]),
                                      decoration: InputDecoration(
                                        // border: OutlineInputBorder(
                                        //   // borderRadius: BorderRadius.circular(10),
                                        //   // borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 1),
                                        // ),
                                        // fillColor: bgEditText.withOpacity(0.2),
                                        // filled: true,

                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        counterText: "",
                                        labelText: "Phone No.",
                                        prefixText: "+91",
                                        alignLabelWithHint: true,
                                        labelStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            )),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 16,
                                        ),
                                        // hintText: 'Phone No.',
                                      ),
                                    ),
                                    Spacer(),
                                    TextFormField(
                                      cursorColor: kPrimaryColor,
                                      style: TextStyle(color: Colors.white),
                                      onSaved: (newValue) {
                                        password = newValue;
                                      },
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      obscureText: hidePassord,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "Required!"),
                                        MinLengthValidator(6,
                                            errorText:
                                                "Password should be atleast 6 characters!"),
                                      ]),
                                      decoration: InputDecoration(
                                        // border: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   borderSide: BorderSide.none,
                                        // ),
                                        // fillColor: bgEditText,
                                        // filled: true,
                                        suffix: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                hidePassord = !hidePassord;
                                              });
                                            },
                                            child: Icon(
                                              hidePassord
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.white,
                                            )),
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: etHintColor,
                                        ),
                                        labelStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            )),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        labelText: 'Password',
                                      ),
                                    ),
                                    size.width < 900 ? SizedBox() : Spacer(),
                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                    // Container(
                                    //   alignment: Alignment.center,
                                    //   child: TextButton(
                                    //     onPressed: () {},
                                    //     child: Text(
                                    //       'Forgot Password?',
                                    //       style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 16,
                                    //           fontWeight:
                                    //               FontWeight.bold),
                                    //     ),
                                    //   ),
                                    // ),
                                    Spacer(
                                      flex: 1,
                                    ),

                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey,
                                          onPrimary: Colors.black,
                                          onSurface: Colors.black,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          validateLoginForm();
                                          
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            hSizedBox1,
                                            model.isLoading
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
                // : Center(child: CircularProgressIndicator())
              ]),
            )));
  }
}
