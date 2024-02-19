import 'package:flutter/material.dart';
import 'package:grievance/common/widget/textfield_pass.dart';
import 'package:grievance/model/content.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen>
    with TickerProviderStateMixin {
  List<Content> list = [];

  @override
  void initState() {
    super.initState();
    getCompanyList();
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
            child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text(
          "Companies Directory",
          style: regularBlack18,
        ),
        centerTitle: true,
        actions: [
          Image.asset(Images.ic_fillter),
        ],
      ),
      body: Column(
        children: [
          _searchWidget(),
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return _companyItem(list[index]);
                }),
          ),
        ],
      ),
    );
  }

  _searchWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: colors.grayLight, width: 1)),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              style: regularBlack14,
              decoration: InputDecoration(
                  suffixIcon: Image.asset(
                    Images.ic_search,
                  ),
                  hintStyle: regularGray14,
                  hintText: "Search Companies",
                  fillColor: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  _companyItem(Content item) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.companyProfileScreen);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colors.grayLight,
                blurRadius: 3.0,
              ),
            ]),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 150),
                  image: NetworkImage(item.url!),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                        Images.rectangle_placeholder,
                        fit: BoxFit.cover,
                        height: 30,
                      ),
                  placeholderErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(
                        Images.rectangle_placeholder,
                        fit: BoxFit.cover,
                        height: 30,
                      ),
                  placeholder: const AssetImage(Images.rectangle_placeholder)),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title!,
                  style: regularBlack16,
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: colors.grayLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "17 Open Tickets",
                      style: regularGray10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: colors.grayLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "12 Resolved Tickets",
                      style: regularGray10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: colors.grayLight,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "2:1 Closure Ratio",
                      style: regularGray10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void getCompanyList() {
    list.add(Content(
        title: "Xsqaure Techies",
        url:
        "https://img-cdn.inc.com/image/upload/w_1920,h_1080,c_fill/images/panoramic/GettyImages-1146500509_433089_nfgomy.jpg",
        status: "open"));
    list.add(Content(
        title: "Google",
        url:
        "https://capacityliveblobstorage.blob.core.windows.net/files/Google%20building.jpg",
        status: "close"));
    list.add(Content(
        title: "Facebook",
        url:
        "https://d1lss44hh2trtw.cloudfront.net/assets/editorial/2021/10/facebook-name-change.jpg",
        status: "close"));
    list.add(Content(
        title: "Linkedin",
        url: "https://live.staticflickr.com/329/19456662052_6643a6c258_b.jpg",
        status: "open"));
    list.add(Content(
        title: "Xsqaure Techies",
        url:
        "https://img-cdn.inc.com/image/upload/w_1920,h_1080,c_fill/images/panoramic/GettyImages-1146500509_433089_nfgomy.jpg",
        status: "open"));
    list.add(Content(
        title: "Google",
        url:
        "https://capacityliveblobstorage.blob.core.windows.net/files/Google%20building.jpg",
        status: "close"));
    list.add(Content(
        title: "Facebook",
        url:
        "https://d1lss44hh2trtw.cloudfront.net/assets/editorial/2021/10/facebook-name-change.jpg",
        status: "close"));
    list.add(Content(
        title: "Linkedin",
        url: "https://live.staticflickr.com/329/19456662052_6643a6c258_b.jpg",
        status: "open"));
    list.add(Content(
        title: "Xsqaure Techies",
        url:
        "https://img-cdn.inc.com/image/upload/w_1920,h_1080,c_fill/images/panoramic/GettyImages-1146500509_433089_nfgomy.jpg",
        status: "open"));
    list.add(Content(
        title: "Google",
        url:
        "https://capacityliveblobstorage.blob.core.windows.net/files/Google%20building.jpg",
        status: "close"));
    list.add(Content(
        title: "Facebook",
        url:
        "https://d1lss44hh2trtw.cloudfront.net/assets/editorial/2021/10/facebook-name-change.jpg",
        status: "close"));
    list.add(Content(
        title: "Linkedin",
        url: "https://live.staticflickr.com/329/19456662052_6643a6c258_b.jpg",
        status: "open"));
    list.add(Content(
        title: "Xsqaure Techies",
        url:
        "https://img-cdn.inc.com/image/upload/w_1920,h_1080,c_fill/images/panoramic/GettyImages-1146500509_433089_nfgomy.jpg",
        status: "open"));
    list.add(Content(
        title: "Google",
        url:
        "https://capacityliveblobstorage.blob.core.windows.net/files/Google%20building.jpg",
        status: "close"));
    list.add(Content(
        title: "Facebook",
        url:
        "https://d1lss44hh2trtw.cloudfront.net/assets/editorial/2021/10/facebook-name-change.jpg",
        status: "close"));
    list.add(Content(
        title: "Linkedin",
        url: "https://live.staticflickr.com/329/19456662052_6643a6c258_b.jpg",
        status: "open"));
    list.add(Content(
        title: "Xsqaure Techies",
        url:
        "https://img-cdn.inc.com/image/upload/w_1920,h_1080,c_fill/images/panoramic/GettyImages-1146500509_433089_nfgomy.jpg",
        status: "open"));
    list.add(Content(
        title: "Google",
        url:
        "https://capacityliveblobstorage.blob.core.windows.net/files/Google%20building.jpg",
        status: "close"));
    list.add(Content(
        title: "Facebook",
        url:
        "https://d1lss44hh2trtw.cloudfront.net/assets/editorial/2021/10/facebook-name-change.jpg",
        status: "close"));
    list.add(Content(
        title: "Linkedin",
        url: "https://live.staticflickr.com/329/19456662052_6643a6c258_b.jpg",
        status: "open"));
    list.add(Content(
        title: "Xsqaure Techies",
        url:
        "https://img-cdn.inc.com/image/upload/w_1920,h_1080,c_fill/images/panoramic/GettyImages-1146500509_433089_nfgomy.jpg",
        status: "open"));
    list.add(Content(
        title: "Google",
        url:
        "https://capacityliveblobstorage.blob.core.windows.net/files/Google%20building.jpg",
        status: "close"));
    list.add(Content(
        title: "Facebook",
        url:
        "https://d1lss44hh2trtw.cloudfront.net/assets/editorial/2021/10/facebook-name-change.jpg",
        status: "close"));
    list.add(Content(
        title: "Linkedin",
        url: "https://live.staticflickr.com/329/19456662052_6643a6c258_b.jpg",
        status: "open"));
  }
}
