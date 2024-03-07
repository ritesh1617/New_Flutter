import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/FileBlocWidget.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/common/widget/textfield.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Zevance.dart';
import 'package:grievance/provider/ProfileProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../../common/custom/country_state_city_picker.dart';

class ZivanceScreen extends StatefulWidget {
  dynamic argument;
   ZivanceScreen(this.argument,{Key? key}) : super(key: key);

  @override
  _ZivanceScreenState createState() => _ZivanceScreenState();
}

class _ZivanceScreenState extends State<ZivanceScreen>
    with TickerProviderStateMixin {
  var blank = true;
  Zevance? zevance=null;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _panController = TextEditingController();

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  FileData? fileProfilePic;
  FileData? fileCover;

  FileData? fileGST;
  FileData? fileCIN;
  FileData? filePAN;

  String profileUrl = "";
  String coverUrl = "";

  String gstUrl = "";
  String cinUrl = "";
  String panUrl = "";

  String gstMediaType = "";
  String cinMediaType = "";
  String panMediaType = "";
  String selectedCity = Constants.choose_city;
  String selectedCountry = Constants.choose_country;
  String selectedState = Constants.choose_state;

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    buttonAnimation = Tween(
      begin: deviceWidth! - 40,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController!,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
    if(widget.argument!=null){
      zevance=widget.argument as Zevance;
      responseZevance(zevance);
    }
    getZevanceDetails();
  }

  @override
  void dispose() {
    super.dispose();
    buttonController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text(
          "Zevance for Business",
          style: regularBlack18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileInfo(),
            _inputController(),
            const SizedBox(
              height: 10,
            ),
            CButton(
              title: "SUBMIT",
              btnAnim: buttonAnimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _clickSave();
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  _profileInfo() {
    var height = 150.0;
    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              Utils.photoPicker(context, ImageType.cover).then((value) {
                if (value != null) {
                  setState(() {
                    fileCover = value as FileData;
                  });
                }
              });
            },
            child: (fileCover == null && coverUrl == "")
                ? Container(
                    width: deviceWidth,
                    height: height,
                    color: colors.grayLight,
                    alignment: Alignment.center,
                    child: Text(
                      "Click Here to Upload Cover Image",
                      style: regularWhite16,
                    ),
                  )
                : (fileCover != null)
                    ? Image.file(
                        fileCover!.file,
                        height: height,
                        width: deviceWidth,
                        fit: BoxFit.cover,
                      )
                    : FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 150),
                        image: NetworkImage(coverUrl),
                        height: height,
                        width: deviceWidth,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.rectangle_placeholder,
                              fit: BoxFit.cover,
                              height: height,
                            ),
                        placeholderErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.rectangle_placeholder,
                              fit: BoxFit.cover,
                              height: height,
                            ),
                        placeholder:
                            const AssetImage(Images.rectangle_placeholder)),
          ),
          GestureDetector(
            onTap: () async {
              Utils.photoPicker(context, ImageType.profile).then((value) {
                if (value != null) {
                  setState(() {
                    fileProfilePic = value as FileData;
                  });
                }
              });
            },
            child: Center(
              child: (fileProfilePic == null && profileUrl == "")
                  ? Container(
                      width: 100.0,
                      height: 100.0,
                      margin: const EdgeInsets.only(top: 100),
                      child: Center(
                          child: Text(
                        "Upload Company Logo Here",
                        style: regularWhite14,
                        textAlign: TextAlign.center,
                      )),
                      decoration: BoxDecoration(
                        color: colors.grayTemp,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: colors.whiteTemp,
                          width: 4.0,
                        ),
                      ),
                    )
                  : Container(
                      width: 100.0,
                      height: 100.0,
                      margin: const EdgeInsets.only(top: 100),
                      decoration: BoxDecoration(
                        color: colors.grayLight,
                        image: (fileProfilePic != null)
                            ? DecorationImage(
                                //image:NetworkImage('https://i.pinimg.com/originals/19/cf/78/19cf789a8e216dc898043489c16cec00.jpg'),
                                image: FileImage(fileProfilePic!.file),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage(profileUrl),
                                fit: BoxFit.cover,
                              ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: colors.whiteTemp,
                          width: 4.0,
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  _inputController() {
    return Column(
      children: [
        CTextField(
          hintText: "Enter Name",
          lable: "Name",
          controller: _nameController,
          keyboardType: TextInputType.text,
        ),
        // CTextField(
        //   hintText: "Enter Company Category",
        //   lable: "Company Category",
        //   controller: _categoryController,
        //   keyboardType: TextInputType.text,
        // ),
        CTextField(
          hintText: "Enter Address here",
          lable: "Address",
          line: 2,
          controller: _addressController,
          keyboardType: TextInputType.streetAddress,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:
            Column(
              children: [
                SelectState(
                  selectedCity:selectedCity,
                  selectedState:selectedState,
                  selectedCountry:selectedCountry,
                  style: const TextStyle(
                      color: colors.blackTemp,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal),
                  onCountryChanged: (value) {
                    setState(() {
                      print(value);
                      selectedCountry=value;
                 //    countryValue = value;
                    });
                  },
                  onStateChanged:(value) {
                    setState(() {
                      print(value);
                      selectedState=value;
                  //    stateValue = value;
                    });
                  },
                  onCityChanged:(value) {
                    setState(() {
                      print(value);
                      selectedCity=value;
                    //  cityValue = value;
                    });
                  },

                ),
                // InkWell(
                //   onTap:(){
                //     print('country selected is $countryValue');
                //     print('country selected is $stateValue');
                //     print('country selected is $cityValue');
                //   },
                //   child: Text(' Check')
                // )
              ],
            )
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 10.0),
        //   child: CSCPicker(
        //     showStates: true,
        //     showCities: true,
        //     flagState: CountryFlag.DISABLE,
        //     dropdownDecoration: BoxDecoration(
        //         borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         color: Colors.white,
        //         border: Border.all(color: Colors.grey.shade300, width: 1)),
        //     disabledDropdownDecoration: BoxDecoration(
        //         borderRadius: const BorderRadius.all(Radius.circular(10)),
        //         color: Colors.grey.shade100,
        //         border: Border.all(color: Colors.grey.shade300, width: 1)),
        //     countrySearchPlaceholder: "Country",
        //     stateSearchPlaceholder: "State",
        //     citySearchPlaceholder: "City",
        //     countryDropdownLabel: "Country",
        //     stateDropdownLabel: "State",
        //     cityDropdownLabel: "City",
        //     defaultCountry: DefaultCountry.India,
        //     selectedItemStyle: const TextStyle(
        //       color: Colors.black,
        //       fontSize: 14,
        //     ),
        //     dropdownHeadingStyle: const TextStyle(
        //         color: Colors.black,
        //         fontSize: 0,
        //         fontWeight: FontWeight.bold),
        //     dropdownItemStyle: const TextStyle(
        //       color: Colors.black,
        //       fontSize: 14,
        //     ),
        //     dropdownDialogRadius: 10.0,
        //     searchBarRadius: 10.0,
        //     onCountryChanged: (value) {
        //       setState(() {
        //         //    countryValue = value;
        //       });
        //     },
        //     onStateChanged: (value) {
        //       setState(() {
        //         //   stateValue = value;
        //       });
        //     },
        //     onCityChanged: (value) {
        //       setState(() {
        //         // cityValue = value;
        //       });
        //     },
        //   ),
        // ),
        CTextField(
          hintText: "Pincode",
          lable: "",
          controller: _pincodeController,
          keyboardType: TextInputType.number,
        ),
        CTextField(
          hintText: "Enter Mobile Number",
          lable: "Mobile Number",
          controller: _mobileNumberController,
          keyboardType: TextInputType.phone,
        ),
        CTextField(
          hintText: "Enter Email Address",
          controller: _emailController,
          lable: "Email Address",
          keyboardType: TextInputType.emailAddress,
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
          alignment: Alignment.topLeft,
          child: Text(
            "Attach Documents",
            style: regularGray14,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Utils.mediaPicker(context,false, true, false, false, true)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          fileGST = value as FileData;
                        });
                      }
                    });
                  },
                  child: FileBlocWidget(
                    fileGST,
                    lable: "Upload GST *\nCertificate",
                    url: gstUrl,
                    mediaType: gstMediaType,
                  )),
              GestureDetector(
                  onTap: () {
                    Utils.mediaPicker(context,false, true, false, false, true)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          fileCIN = value as FileData;
                        });
                      }
                    });
                  },
                  child: FileBlocWidget(
                    fileCIN,
                    lable: "Upload\nCIN",
                    url: cinUrl,
                    mediaType: cinMediaType,
                  )),
              GestureDetector(
                  onTap: () {
                    Utils.mediaPicker(context,false, true, false, false, true)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          filePAN = value as FileData;
                        });
                      }
                    });
                  },
                  child: FileBlocWidget(
                    filePAN,
                    lable: "Upload\nPAN card",
                    url: panUrl,
                    mediaType: panMediaType,
                  )),
            ],
          ),
        ),
        CTextField(
          hintText: "Enter GST Number",
          lable: "*GST Number",
          controller: _gstNumberController,
          keyboardType: TextInputType.text,
        ),
        CTextField(
          hintText: "Enter CIN Number",
          lable: "CIN Number",
          controller: _cinController,
          keyboardType: TextInputType.text,
        ),
        CTextField(
          hintText: "Enter PAN Number",
          lable: "PAN Number",
          controller: _panController,
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  void _clickSave() {
    String name = _nameController.text.toString();
    String address = _addressController.text.toString();
    String pincode= _pincodeController.text.toString();
    String mobileNumber = _mobileNumberController.text.toString();
    String email = _emailController.text.toString();
    String gstNumber = _gstNumberController.text.toString();
    String cin = _cinController.text.toString();
    String pan = _panController.text.toString();

    if (name.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter name!");
      return;
    } else if (address.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter address!");
      return;
    } else if (selectedCountry==Constants.choose_country) {
      ToastUtils.setSnackBar(context, "Please select country!");
      return;
    } else if (mobileNumber.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter mobile number!");
      return;
    } else if (mobileNumber.isNotEmpty && !isPhone(mobileNumber)) {
      ToastUtils.setSnackBar(context, "Please enter valid mobile number!");
      return;
    } else if (email.isNotEmpty && !isEmail(email)) {
      ToastUtils.setSnackBar(context, "Please enter valid email!");
      return;
    } else if (gstNumber.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter gst number!");
      return;
    } else if (gstNumber.length != 15) {
      ToastUtils.setSnackBar(context, "Please enter valid gst number!");
      return;
    }
    var country="",state="",city="";
    if(selectedCountry!=Constants.choose_country)
      country=selectedCountry;
    if(selectedState!=Constants.choose_state)
      state=selectedState;
    if(selectedCity!=Constants.choose_city)
      city=selectedCity;

    addZevanceApi(name, address, mobileNumber, email, gstNumber, cin, pan,country,state,city,pincode);
  }

  void addZevanceApi(String name, String address, String mobileNumber,
      String email, String gst, String cin, String pan, String country, String state, String city, String pincode) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<ProfileProvider>(context, listen: false)
          .addZevance(context, name, address, mobileNumber, email, gst, cin,
              pan,country,state,city,pincode, fileGST, fileCIN, filePAN, fileProfilePic, fileCover)
          .then((value) {
        responseAddZevance(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseAddZevance(int value) async {
    await buttonController!.reverse();
    if (value == 200) {
      ToastUtils.setSnackBar(context, "Zevance Updated Successfully!");
      navigatorKey.currentState!.pop(200);
    }
  }

  void getZevanceDetails() async {
    try {
      // Log user in
      await Provider.of<ProfileProvider>(context, listen: false)
          .getZevanceDetails()
          .then((value) {
        responseZevance(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseZevance(Zevance? value) async {
    if (value != null) {
      _nameController.text = value.name.toString();
      _addressController.text = value.address.toString();
      _mobileNumberController.text = value.mobileNo.toString();
      _emailController.text = value.email.toString();
      _gstNumberController.text = value.gstNumber.toString();
      _cinController.text = value.cinNumber.toString();
      _panController.text = value.panNumber.toString();
      _pincodeController.text = value.pincode.toString();

      if(value.country!.isNotEmpty){
        setState(() {
          selectedCountry=value.country!;
          print(selectedCountry);
        });
      }
      if(value.state!.isNotEmpty){
        setState(() {
          selectedState=value.state!;
          print(selectedState);
        });
      }
      if(value.city!.isNotEmpty){
        setState(() {
          selectedCity=value.city!;
          print(selectedCity);
        });
      }
      if (value.gstCert != "") {
        setState(() {
          gstUrl = value.gstCert!;
          gstMediaType = value.gstCertMediaType!;
        });
      }
      if (value.cinCert != "") {
        setState(() {
          cinUrl = value.cinCert!;
          cinMediaType = value.cinCertMediaType!;
        });
      }
      if (value.panCard != "") {
        setState(() {
          panUrl = value.panCard!;
          panMediaType = value.panCerdMediaType!;
        });
      }
      if (value.image != "") {
        setState(() {
          profileUrl = value.image!;
        });
      }
      if (value.coverImage != "") {
        setState(() {
          coverUrl = value.coverImage!;
        });
      }
    }
  }
}
