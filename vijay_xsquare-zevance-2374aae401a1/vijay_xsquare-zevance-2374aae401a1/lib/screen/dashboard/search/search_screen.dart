import 'package:flutter/material.dart';
import 'package:grievance/screen/dashboard/search/search_people_screen.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

import 'search_company_screen.dart';
import 'search_grievance_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  var _value = 20.0;

  final TextEditingController _searchController = TextEditingController();
  TabController? _tabController;

  List<Widget> list = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    list.add(SearchGrievanceScreen(_searchController));
    list.add(SearchCompanyScreen(_searchController));
    list.add(SearchPeopleScreen(_searchController));
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            _searchWidget(),
            TabBar(
              controller: _tabController,
              labelColor: colors.primary,
              unselectedLabelColor: colors.grayTemp,
              indicatorColor: colors.primary,
              tabs: const [
                Tab(
                  text: ("Grievances"),
                ),
                Tab(
                  text: ("Companies"),
                ),
                Tab(
                  text: ("People"),
                )
              ],
            ),
            Expanded(
              child: list[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }

  _searchWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            navigatorKey.currentState!.pop();
          },
          child: Container(width:20,child: const Image(image: AssetImage(Images.ic_back)),   margin: const EdgeInsets.only(left: 15),),
        ),
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
              controller: _searchController,
              decoration: InputDecoration(
                  suffixIcon: Container(
                    width: 20,
                    height: 20,
                    padding: EdgeInsets.all(15),
                    child: Image.asset(
                      Images.ic_search,
                    ),
                  ),
                  hintStyle: regularGray14,
                  hintText: "Search",
                  fillColor: Colors.white),
            ),
          ),
        )
      ],
    );
  }



}
