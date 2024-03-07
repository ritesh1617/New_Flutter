import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/FileBlocWidget.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/common/widget/rounded_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/services/BackendService.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:popover/popover.dart';

class AddGrievanceScreen extends StatefulWidget {
  final dynamic _argument;

  const AddGrievanceScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _AddGrievanceScreenState createState() => _AddGrievanceScreenState();
}

class _AddGrievanceScreenState extends State<AddGrievanceScreen>
    with TickerProviderStateMixin {
  //Create Profile Controller
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _outcomeDetailsController =
      TextEditingController();

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;
  bool anonymous = false;

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  String companyId = "";
  String companyName = "";
  String companyLogo = "";
  FileData? selectedFile = null;
  FileData? selectedProofFile;


  Widget? companyIcon;
  Widget? verifiedIcon;
  bool logoVisible = false;

  final _outcome = ["Refund", "Return", "Call back"];
  var _selectedOutCome = "Refund";

  late List<DropdownMenuItem<String>> menuItems = [];

  void _printLatestValue() {
    setState(() {
      logoVisible = (_companyNameController.text == companyName);
    });
  }


  @override
  void initState() {
    super.initState();
    if (widget._argument != null && widget._argument is FileData) {
      selectedFile = widget._argument as FileData;
    }else if (widget._argument != null && widget._argument is Company) {
      Company company = widget._argument as Company;
      _setSelectedCompanyDetails(company);
    }
    for (int i = 0; i < _outcome.length; i++) {
      //* on 1st index there will be no divider
      menuItems.add(
        DropdownMenuItem<String>(
          value: _outcome[i],
          child: Text(
            _outcome[i],
            style: regularBlack14,
          ),
        ),
      );
    }
    _companyNameController.addListener(_printLatestValue);
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
            child: Container(
              padding: const EdgeInsets.all(15),
              child: const Image(image: AssetImage(Images.ic_back)),
            )),
        title: Text(
          "Add Grievance",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 25.0,
                end: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company Name *",
                    style: boldGray13,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _companyNameController,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 1,
                        cursorColor: colors.primary,
                        style: regularBlack14,
                        decoration: InputDecoration(
                          fillColor: colors.whiteTemp,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colors.grayLight, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colors.grayLight, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintText: "Enter Company Name",
                          hintStyle:regularGray14,
                          // filled: true,
                          // fillColor: Theme.of(context).colorScheme.lightWhite,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 40, maxHeight: 25),

                          prefixIcon: (logoVisible) ? companyIcon : null,
                          suffixIcon: (logoVisible) ? verifiedIcon : null,
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Theme.of(context).colorScheme.fontColor),
                          //   borderRadius: BorderRadius.circular(10.0),
                          // ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        // setState(() {
                        //   logoVisible=(_companyNameController.text==companyName);
                        // });
                        return await BackendService.getSuggestions(pattern);
                      },
                      itemBuilder: (context, Map<String, String> suggestion) {
                        return ListTile(
                          leading: FadeInImage(
                              fadeInDuration: const Duration(milliseconds: 150),
                              image: NetworkImage(suggestion['logo']!),
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                    Images.rectangle_placeholder,
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                  ),
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                        Images.rectangle_placeholder,
                                        fit: BoxFit.cover,
                                        height: 30,
                                        width: 30,
                                      ),
                              placeholder: const AssetImage(
                                  Images.rectangle_placeholder)),
                          title: Row(
                            children: [
                              Text(
                                suggestion['company_name']!,
                                style: const TextStyle(
                                    color: colors.blackTemp,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                (suggestion['company_name'] != null &&
                                        suggestion['company_name'] ==
                                            "verified")
                                    ? Images.ic_verified
                                    : Images.ic_unverified,
                                width: 13,
                                height: 13,
                              )
                            ],
                          ),
                          // subtitle: Text('${suggestion['founder']}', style: TextStyle(
                          //     color: colors.grayTemp,
                          //     fontSize: 14.0,
                          //     fontWeight: FontWeight.normal),),
                        );
                      },
                      onSuggestionSelected: (Map<String, String> suggestion) {
                        // your implementation here
                        _companyNameController.text =
                            suggestion['company_name']!;
                        companyName = suggestion['company_name']!;
                        companyId = suggestion['id']!;
                        companyLogo = suggestion['logo']!;
                        print(suggestion);
                        var isVerified = suggestion['is_verified'] ?? "";
                        setState(() {
                          logoVisible = true;
                          companyIcon = Container(
                              margin: const EdgeInsets.all(4),
                              child: FadeInImage(
                                  fadeInDuration:
                                      const Duration(milliseconds: 150),
                                  image: NetworkImage(suggestion['logo']!),
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.contain,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                            Images.rectangle_placeholder,
                                            fit: BoxFit.cover,
                                            height: 20,
                                            width: 20,
                                          ),
                                  placeholderErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                            Images.rectangle_placeholder,
                                            fit: BoxFit.cover,
                                            height: 20,
                                            width: 20,
                                          ),
                                  placeholder: const AssetImage(
                                      Images.rectangle_placeholder)));
                          verifiedIcon = (isVerified == "verified")
                              ? Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Image.asset(
                                    Images.ic_verified,
                                    width: 10,
                                    height: 10,
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Image.asset(
                                    Images.ic_unverified,
                                    width: 10,
                                    height: 10,
                                  ),
                                );
                        });
                      },
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        elevation: 5.0,
                        color: colors.whiteTemp,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ],
              ),
            ),
            CRoundedTextField(
              hintText: "Enter Grievance Details",
              lable: "Grievance Details *",
              line: 4,
              controller: _detailsController,
              keyboardType: TextInputType.text,
            ),
            Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 10.0,
                  start: 25.0,
                  end: 25.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Desired Outcome",
                      style: boldGray13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            fillColor: colors.whiteTemp,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colors.grayLight, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colors.grayLight, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colors.grayLight, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintText: "Enter Desired Outcome",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.fontColor,
                                    fontWeight: FontWeight.normal),
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 0, bottom: 5, right: 10),
                          ),
                          isEmpty: _selectedOutCome == "",
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              itemHeight: 35,
                              selectedItemHighlightColor: colors.backgroundColor,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              offset: const Offset(0, -20),
                              //dropdownWidth: deviceWidth! - 80,
                              style: const TextStyle(
                                  color: colors.blackTemp,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal),
                              value: _selectedOutCome,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedOutCome = newValue!;
                                  state.didChange(newValue);
                                });
                              },
                              icon: Icon(
                                // Add this
                                Icons.keyboard_arrow_down_rounded, // Add this
                                color: colors.grayTemp, //
                                // Add this
                              ),
                              items: menuItems
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )),
            (_selectedOutCome == "Other")
                ? CRoundedTextField(
                    hintText: "Enter Desired Outcome",
                    lable: "Desired Outcome Details",
                    controller: _outcomeDetailsController,
                    keyboardType: TextInputType.text,
                  )
                : Container(),
            Container(
              width: deviceWidth,
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 25.0,
                end: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: Image.asset(
                          Images.icon_attach,
                          width: 15,
                          height: 15,
                        )),
                        const WidgetSpan(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        TextSpan(
                          text: "Attachments * (Only 1 File)",
                          style: boldGray13,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils.mediaPicker(context, true, true, false, true, false)
                          .then((value) {
                        // print("++++++");
                        if (value != null) {
                          setState(() {
                            selectedFile = value as FileData;
                          });
                          // print(selectedFile!.type);
                        }
                      });
                    },
                    child: FileBlocWidget(
                      selectedFile,
                      onRemove: () => {
                        setState(() {
                          selectedFile = null;
                        })
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: deviceWidth,
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 25.0,
                end: 25.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            child: Image.asset(
                          Images.icon_attach,
                          width: 15,
                          height: 15,
                        )),
                        const WidgetSpan(
                          child: SizedBox(
                            width: 5,
                          ),
                        ),
                        TextSpan(
                          text: "Attach Proof of Purchase (Only 1 File)",
                          style: boldGray13,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Utils.mediaPicker(context, true, true, false, false, true)
                          .then((value) {
                        // print("++++++");
                        if (value != null) {
                          setState(() {
                            selectedProofFile = value as FileData;
                          });
                          // print(selectedFile!.type);
                        }
                      });
                    },
                    child: FileBlocWidget(
                      selectedProofFile,
                      onRemove: () => {
                        setState(() {
                          selectedProofFile = null;
                        })
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Checkbox(
                  value: anonymous,
                  activeColor: colors.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  fillColor: MaterialStateProperty.all(colors.secondary),
                  side: MaterialStateBorderSide.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const BorderSide(color: colors.secondary);
                    } else {
                      return const BorderSide(color: colors.black38, width: 1);
                    }
                  }),
                  onChanged: (bool? value) {
                    // This is where we update the state when the checkbox is tapped
                    setState(() {
                      anonymous = value!;
                    });
                  },
                ),
                Text(
                  "Submit Grievance as an anonymous.",
                  style: boldGray13,
                ),
                const SizedBox(
                  width: 5,
                ),
                Builder(builder: (c) {
                  return GestureDetector(
                      child: Image.asset(
                        Images.icon_info,
                        width: 15,
                        height: 15,
                      ),
                      onTap: () {
                        showPopover(
                          context: c,
                          bodyBuilder: (context) => Container(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              Lables.anonymous_msg,
                              style: regularBlack14,
                            ),
                          ),
                          width: deviceWidth! - 30,
                          onPop: () => {},
                          direction: PopoverDirection.top,
                        );
                      });
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "By clicking Submit you confirm that you have read and agreed to the ",
                      style: regularGray10,
                    ),
                    TextSpan(
                      text: "FAQ, ",
                      style: regularGray10.copyWith(color: colors.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.faq_url);
                        },
                    ),
                    TextSpan(
                      text: "Terms of Use ",
                      style: regularGray10.copyWith(color: colors.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(
                              Constants.terms_and_conditions_url);
                        },
                    ),
                    TextSpan(
                      text: "and ",
                      style: regularGray10,
                    ),
                    TextSpan(
                      text: "Privacy Policy, ",
                      style: regularGray10.copyWith(color: colors.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.privacy_url);
                        },
                    ),
                    TextSpan(
                      text:
                          "and that your information is accurate, true, complete and not misleading.",
                      style: regularGray10,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
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

  void _clickSave() {
    String cname = _companyNameController.text.toString().trim();
    String title = _titleController.text.toString().trim();
    String details = _detailsController.text.toString().trim();
    String desired = _outcomeDetailsController.text.toString().trim();

    if (cname.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter company name");
      return;
    } else if (cname != companyName) {
      ToastUtils.setSnackBar(context, "Please select company from dropdown");
      return;
    }
    // else if (title.isEmpty) {
    //   ToastUtils.setSnackBar(context, "Please enter grievance title!");
    //   return;
    // }
    else if (details.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter grievance details");
      return;
    } else if (_selectedOutCome == "Other" && desired.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter desired outcome details");
      return;
    } else if (selectedFile == null) {
      ToastUtils.setSnackBar(context, "Please select an attachment");
      return;
    }
    String cid = "";
    if (cname == companyName) {
      cid = companyId;
    }
    addGrievanceApi(cid, cname, title, details, desired);
  }

  void addGrievanceApi(
      String cid, String cname, title, details, desired) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<GrievanceProvider>(context, listen: false)
          .addGrievance(context, title, details, cid, cname, _selectedOutCome,
              desired, selectedFile, selectedProofFile, anonymous)
          .then((value) {
        responseAddGrievance(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseAddGrievance(Grievance? value) async {
    await buttonController!.reverse();
    if (value != null) {
      navigatorKey.currentState!
          .pushNamed(RouteName.thankyouScreen, arguments: value)
          .then((value) {
        if (value == 201) {
          setState(() {
            _companyNameController.text = "";
            _titleController.text = "";
            _detailsController.text = "";
            _outcomeDetailsController.text = "";
            _selectedOutCome = "Refund";
            companyId = "";
            companyName = "";
            companyLogo = "";
            logoVisible = false;
            selectedFile = null;
            selectedProofFile = null;
          });
        } else {
          navigatorKey.currentState!.pop();
        }
      });
    } else {
      ToastUtils.setSnackBar(context, "Something Wrong!");
    }
  }

  void _setSelectedCompanyDetails(Company company) {
    _companyNameController.text =company.companyName.toString();
    companyName = company.companyName.toString();
    companyId = company.id.toString();
    companyLogo = company.logo.toString();

    var isVerified = company.is_verified.toString() ?? "";
    setState(() {
      logoVisible = true;
      companyIcon = Container(
          margin: const EdgeInsets.all(4),
          child: FadeInImage(
              fadeInDuration:
              const Duration(milliseconds: 150),
              image: NetworkImage(companyLogo),
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              imageErrorBuilder:
                  (context, error, stackTrace) =>
                  Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: 20,
                    width: 20,
                  ),
              placeholderErrorBuilder:
                  (context, error, stackTrace) =>
                  Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: 20,
                    width: 20,
                  ),
              placeholder: const AssetImage(
                  Images.rectangle_placeholder)));
      verifiedIcon = (isVerified == "verified")
          ? Container(
        padding: const EdgeInsets.all(15),
        child: Image.asset(
          Images.ic_verified,
          width: 10,
          height: 10,
        ),
      )
          : Container(
        padding: const EdgeInsets.all(15),
        child: Image.asset(
          Images.ic_unverified,
          width: 10,
          height: 10,
        ),
      );
    });
  }
}
