import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CompanyItemWidget.dart';
import 'package:grievance/model/Company.dart';
import 'package:grievance/provider/CompanyProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchCompanyScreen extends StatefulWidget {

  TextEditingController searchController;
  SearchCompanyScreen(this.searchController, {Key? key}) : super(key: key);

  @override
  _SearchCompanyScreenState createState() => _SearchCompanyScreenState();
}

class _SearchCompanyScreenState extends State<SearchCompanyScreen> {

  var _isLoadingCompany = false;
  List<Company> companyList = [];
  int companyPage = 1;
  String searchText = "";
  ScrollController companyController = ScrollController();

  void _scrollCompanyListener() {
    if (!_isLoadingCompany) {
      if (companyController.position.pixels ==
          companyController.position.maxScrollExtent) {
        companyPage = companyPage + 1;
        companyListApiCall(companyPage);
      }
    }
  }

  void _searchListener() {
    var text = widget.searchController.text.toString();
    //print(text);
    searchText = text;
    Timer(const Duration(microseconds: 400), () {
      companyListApiCall(1);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_searchListener);
    searchText = widget.searchController.text;
    companyController = ScrollController()
      ..addListener(_scrollCompanyListener);
    companyListApiCall(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SafeArea(
        child: _getCompanyList(),
      ),
    );
  }


  _getCompanyList() {
    return (_isLoadingCompany && companyPage == 1) ? shimmerCompany(
        context) : _companyWidget();
  }

  _companyWidget() {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 7.5),
        itemCount: companyList.length,
        shrinkWrap: true,
        controller: companyController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return CompanyItemWidget(companyList[index]);
        });
  }


  //+++++++++++++ Company API +++++++++++

  Future<void> companyListApiCall(int page) async {
    companyPage=page;
    print(_isLoadingCompany);
   // if (!_isLoadingCompany) {
      setState(() {
        _isLoadingCompany = true;
      });
      try {
        await Provider.of<CompanyProvider>(context, listen: false)
            .getCompanyList(context,page, searchText)
            .then((value) => {companyListResponse(value,page)});
      } on HttpException catch (error) {
        setState(() {
          _isLoadingCompany = false;
        });
        print(error);
      } catch (error) {
        setState(() {
          _isLoadingCompany = false;
        });
        print(error);
      }
   // }
  }

  void companyListResponse(List<Company> data,int page) async {
    if (page == 1) {
      companyList.clear();
    }
    setState(() {
      _isLoadingCompany = false;
      print(data.length);
      companyList.addAll(data);
    });
  }

  Widget shimmerCompany(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Theme
            .of(context)
            .colorScheme
            .simmerBase,
        highlightColor: Theme
            .of(context)
            .colorScheme
            .simmerHigh,
        child: SingleChildScrollView(
          child: Column(
            children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map((_) => Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 180.0,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .white,
                        ),
                      ),
                    ],
                  ),
                ))
                .toList(),
          ),
        ),
      ),
    );
  }

}
