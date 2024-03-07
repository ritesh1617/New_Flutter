library country_state_city_picker_nona;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:country_state_city_picker/model/select_status_model.dart'
    as StatusModel;
import 'package:grievance/utils/constants.dart';

import '../../theme/color.dart';

class SelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;
  final String? selectedCity;
  final String? selectedCountry;
  final String? selectedState;
  final TextStyle? style;
  final Color? dropdownColor;

  const SelectState(
      {Key? key,
      required this.onCountryChanged,
      required this.onStateChanged,
      required this.onCityChanged,
      this.selectedCity,
      this.selectedState,
      this.selectedCountry,
      this.style,
      this.dropdownColor})
      : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  List<String> _cities = [Constants.choose_city];
  List<String> _country = [Constants.choose_country];
  String _selectedCity = Constants.choose_city;
  String _selectedCountry = Constants.choose_country;
  String _selectedState = Constants.choose_state;
  List<String> _states = [Constants.choose_state];
  var responses;

  @override
  void initState() {
    getCounty();
    setData();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString(
        'packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    countryres.forEach((data) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      if (!mounted) return;
      setState(() {
        _country.add(model.name!);
      });
    });

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      if (!mounted) return;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          print(statename.toString());
          _states.add(statename.toString());
        }
      });
    });
    _states.sort((a, b){ //sorting in ascending order
      return a.compareTo(b);
    });
    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = Constants.choose_state;
      _states = [Constants.choose_state];
      _selectedCity = Constants.choose_city;
      _cities = [Constants.choose_city];
      _selectedCountry = value;
      this.widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = Constants.choose_city;
      _cities = [Constants.choose_city];
      _selectedState = value;
      this.widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      this.widget.onCityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, left: 5, right: 5),
          padding: EdgeInsets.only(left: 15),
          decoration: ShapeDecoration(
            color: colors.whiteTemp,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.grayLight, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: widget.dropdownColor,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10.0),
              items: _country.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      Text(
                        dropDownStringItem,
                        style: widget.style,
                      )
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => _onSelectedCountry(value!),
              value: _selectedCountry,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15, left: 5, right: 5),
          padding: EdgeInsets.only(left: 15),
          decoration: ShapeDecoration(
            color: colors.whiteTemp,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.grayLight, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: widget.dropdownColor,
              isExpanded: true,
              items: _states.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem, style: widget.style),
                );
              }).toList(),
              onChanged: (value) => _onSelectedState(value!),
              value: _selectedState,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15, left: 5, right: 5),
          padding: EdgeInsets.only(left: 15),
          decoration: ShapeDecoration(
            color: colors.whiteTemp,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.grayLight, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: widget.dropdownColor,
              isExpanded: true,
              items: _cities.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem, style: widget.style),
                );
              }).toList(),
              onChanged: (value) => _onSelectedCity(value!),
              value: _selectedCity,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Future<void> setData() async {
    print("setData");
    if (widget.selectedCountry != Constants.choose_country) {
     await _selectCountry(widget.selectedCountry!);
    }
    if (widget.selectedState != Constants.choose_state) {
     await _selectState(widget.selectedState!);
    }
    if (widget.selectedCity != Constants.choose_city) {
     await _selectCity(widget.selectedCity!);
    }
  }

  Future<void> _selectCountry(String value) async {
    if (!mounted) return;
    var countryres = await getResponse() as List;
    List<String> c = [];
    countryres.forEach((data) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      if (!mounted) return;
      setState(() {
        c.add(model.name!);
      });
    });

    setState(() {
      _selectedCountry = value;
      _country = c;
      this.widget.onCountryChanged(value);
      getState();
    });
  }
  Future<void> _selectState(String value) async {
    var response = await getResponse();
    List<String> s = [];
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      if (!mounted) return;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          print(statename.toString());
          s.add(statename.toString());
        }
      });
    });
    s
        .sort((a, b){ //sorting in ascending order
      return a.compareTo(b);
    });
    setState(() {
      _selectedState = value;
      _states = s;
      this.widget.onStateChanged(value);
      getCity();
    });
  }
  Future<void> _selectCity(String value) async {
    var response = await getResponse();
    List<String> c = [];
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            print(citynames.toString());
            c.add(citynames.toString());
          }
        });
      });
    });
    setState(() {
      _selectedCity = value;
      _cities = c;
      this.widget.onCityChanged(value);
    });
  }
}
