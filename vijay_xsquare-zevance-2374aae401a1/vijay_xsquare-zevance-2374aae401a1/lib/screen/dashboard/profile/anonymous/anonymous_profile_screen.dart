import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PersonalGrievanceWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:provider/provider.dart';
import 'package:grievance/provider/PeopleProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class AnonymousProfileScreen extends StatefulWidget {


  const AnonymousProfileScreen({Key? key}) : super(key: key);

  @override
  _AnonymousProfileScreenState createState() => _AnonymousProfileScreenState();
}

class _AnonymousProfileScreenState extends State<AnonymousProfileScreen>
    with TickerProviderStateMixin {





  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
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
            child: Container(padding: const EdgeInsets.all(15),child: const Image(image: AssetImage(Images.ic_back)),)),
        title: Text(
          "Public Profile",
          style:boldBlack18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_profileInfo(),
          _bio()
          //  _grievance()
          ],
        ),
      ),
    );
  }

  _profileInfo() {
    var height = 150.0;
    return Column(
      children: [
        Stack(
          children: [
            FadeInImage(
                fadeInDuration: const Duration(milliseconds: 150),
                image: NetworkImage('https://yourlawnwise.com/wp-sdd.png'),
                height: height,
                width: deviceWidth,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.anonymous_banner,
                      fit: BoxFit.cover,
                      width: deviceWidth,
                      height: height,
                    ),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.anonymous_banner,
                      fit: BoxFit.cover,
                      width: deviceWidth,
                      height: height,
                    ),
                placeholder: const AssetImage(Images.anonymous_banner)),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  border: Border.all(width: 5,color: colors.whiteTemp),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [BoxShadow(
                      color: colors.grayTemp,
                      blurRadius: 1
                  )],
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/anonymous-512.png',
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 150),
                      image:NetworkImage('https://cdn1.iconfinder.com/data/icons/social-black-buttons/512/anonymous-512.png'),
                      width: 90.0,
                      height: 90.0,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                        Images.person_placeholder,
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                        colorBlendMode: BlendMode.modulate,
                        fit: BoxFit.cover,
                        width: 90.0,
                        height: 90.0,
                      ),
                      placeholderErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            Images.person_placeholder,
                            fit: BoxFit.cover,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                            colorBlendMode: BlendMode.modulate,
                            width: 90.0,
                            height: 90.0,
                          ),
                      placeholder: const AssetImage(Images.person_placeholder,)),
                ),
              ),
            ),
          /*  Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.only(top: 100),
                decoration: BoxDecoration(
                  color: colors.grayLight,
                  image: DecorationImage(
                    image: (users != null && users!.image!.isNotEmpty)
                        ? NetworkImage(users!.image!)
                        : const NetworkImage(
                            'https://yourlawnwise.com/wp-content.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  border: Border.all(
                    color: colors.whiteTemp,
                    width: 4.0,
                  ),
                ),
              ),
            )*/
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Anonymous User",
          style: boldBlack16,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: Text(
            "Registered with Zevance but Anonymous to the world.",
           // "Brainstorming my perfect headline. Coming soon!",
            textAlign: TextAlign.center,
            style: regularBlack12,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // GestureDetector(
        //   onTap: () {
        //     _clickFollow();
        //   },
        //   child: Container(
        //     width: 90,
        //     padding: const EdgeInsets.only(top: 5, bottom: 5),
        //     decoration: BoxDecoration(
        //         gradient: const LinearGradient(
        //             colors: [colors.firstColor, colors.secondColor]),
        //         borderRadius: BorderRadius.circular(15)),
        //     child: Center(
        //         child: Text(
        //       (users!.follow!) ? "Unfollow" : "Follow",
        //       style: regularWhite14,
        //     )),
        //   ),
        // ),
        Container(
          height: 1,
          color: colors.grayLight,
          margin:
              const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {

              },
              child: Container(
                color: colors.transparent,
                child: Column(
                  children: [
                    Text(
                      "0",
                      style: normalBlack14,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Total Followers",
                      style: regularGray12,
                    ),
                  ],
                ),
              ),
            )),
            Container(
              height: 30,
              width: 1,
              color: colors.grayTemp,
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {

              },
              child: Container(
                color: colors.transparent,
                child: Column(
                  children: [
                    Text(
                      "0",
                      style: normalBlack14,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Total Following",
                      style: regularGray12,
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ],
    );
  }

  _bio() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bio",
            style: boldBlack14,
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
          ),
          Text(
            "I will be updating my anonymous bio shortly.",
            style: regularBlack12,
          ),
        ],
      ),
    );
  }




}
