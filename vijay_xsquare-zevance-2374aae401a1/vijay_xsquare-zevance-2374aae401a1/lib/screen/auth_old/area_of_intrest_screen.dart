import 'package:flutter/material.dart';
import 'package:grievance/model/Category.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';

import '../../common/widget/button.dart';
import '../../utils/constants.dart';
import 'package:provider/provider.dart';

class AreaInterestScreen extends StatefulWidget {
  const AreaInterestScreen({Key? key}) : super(key: key);

  @override
  _AreaInterestScreenState createState() => _AreaInterestScreenState();
}

class _AreaInterestScreenState extends State<AreaInterestScreen>
    with TickerProviderStateMixin {
  List<Category> list = [];
  List<int> selectedInterestId = [];

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  int count = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
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
            child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text(
          "Select Your Interests",
          style: regularBlack18,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(list.length, (index) {
                    return Center(
                      child: _interestItem(list[index], index),
                    );
                  })),
            ),
            CButton(
              title: "Submit ($count)",
              btnAnim: buttonAnimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _submitInterest();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _interestItem(Category item, int index) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            FadeInImage(
                fadeInDuration: const Duration(milliseconds: 150),
                image: NetworkImage(item.categoryImg!),
                fit: BoxFit.cover,
                height: 180,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.person_placeholder,
                      fit: BoxFit.cover,
                    ),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.person_placeholder,
                      fit: BoxFit.cover,
                    ),
                placeholder: const AssetImage(Images.person_placeholder)),
            Opacity(
              opacity: 1,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black]))),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.categoryName!,
                    style: regularWhite12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            (item.interrest!)
                ? const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      size: 40,
                      color: colors.whiteTemp,
                    ),
                  )
                : Container()
          ],
        ),
      ),
      onTap: () async {
        setState(() {
          list[index].interrest = !list[index].interrest!;
          _getCount();
        });
      },
    );
  }

  void _getCategory() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .getCategory(context)
        .then((value) {
      setState(() {
        list.clear();
        list.addAll(value);
      });
      _getUserInterest();
    });
  }

  void _getUserInterest() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .getUserInterest(context)
        .then((value) {

      for (int i = 0; i < value.length; i++) {
        for (int j = 0; j < list.length; j++) {
          if (value[i].id == list[j].id) {
            setState(() {
              list[j].interrest = true;
            });
            break;
          }
        }
      }
      _getCount();
    });
  }

  void _getCount() {
    var c = 0;
    selectedInterestId = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].interrest == true) {
        selectedInterestId.add(list[i].id!);
        c++;
      }
    }
    setState(() {
      count = c;
    });
  }

  void _submitInterest() async {
    if (count < 3) {
      ToastUtils.setSnackBar(context, "Please Select Minimum 3 Interest");
      return;
    }
    _playAnimation();
    String ids = selectedInterestId.map((i) => i.toString()).join(",");

    await Provider.of<AuthProvider>(context, listen: false)
        .updateCategory(context, ids)
        .then((value) {
          buttonController!.stop();
      if (value) {
        navigatorKey.currentState!.pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
      }
    });
    // navigatorKey.currentState!.pushNamedAndRemoveUntil(
    //     RouteName.dashboardScreen, (route) => false);
  }
}
