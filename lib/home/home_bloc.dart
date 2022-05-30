import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:exparement/model/pin_code_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PinCodeCheck { AllSelected, NoneSelected, PartiallySelected }

class HomeBloc {
  // region Common Variables
  BuildContext context;
  bool openForOrder = false;
  late PinCodeResponse pinCodeResponse;
  List<int> selectedPinCodes = [];

  // endregion

  //region Controller
  final storeOnlineCtrl = StreamController<bool>.broadcast();

  //endregion

  // region | Constructor |
  HomeBloc(this.context);

  // endregion

  // region Init
  void init() {
    pinCodeResponse = PinCodeResponse();
    jsonDataOModel();
  }

// endregion

//region Json data to model class
  void jsonDataOModel() async {
    final String response = await rootBundle.loadString('assets/pin_code.json');
    Map<String, dynamic> jsonResponse = json.decode(response);
    pinCodeResponse = PinCodeResponse.fromJson(jsonResponse);

    print(pinCodeResponse.pinCode!.first.cities!.first.city);
  }

//endregion

// region On change State
  void onChangeState(PinCode pinCode) {
    pinCode.isVisible = true;
    var data = pinCodeResponse.pinCode!.firstWhere((element) => element.state == pinCode.state);
    data.stateMarked = 2 - data.stateMarked!;
    for (var city in data.cities!) {
      city.cityMarked = data.stateMarked;
      for (var pincode in city.pincodes!) pincode.pincodeMarked = city.cityMarked;
    }
    if (!storeOnlineCtrl.isClosed) storeOnlineCtrl.sink.add(true);
  }

// endregion

// region On change City
  void onChangeCity(Cities cities, PinCode pinCode) {
    cities.cityMarked = 2 - cities.cityMarked!;
    for (var pincode in cities.pincodes!) pincode.pincodeMarked = cities.cityMarked;

    if (isAllCityChecked(pinCode) == PinCodeCheck.AllSelected) {
      pinCode.stateMarked = 2;
    } else if (isAllCityChecked(pinCode) == PinCodeCheck.PartiallySelected) {
      pinCode.stateMarked = 1;
    } else {
      pinCode.stateMarked = 0;
    }
    if (!storeOnlineCtrl.isClosed) storeOnlineCtrl.sink.add(true);
  }

// endregion

  // region On change PinCode
  void onChangePinCode(Pincodes pincodes, Cities city, PinCode pinCode) {
    pincodes.pincodeMarked = 2 - pincodes.pincodeMarked!;

    // check pincode
    if (isAllPinCodeChecked(city) == PinCodeCheck.AllSelected) {
      city.cityMarked = 2;
    } else if (isAllPinCodeChecked(city) == PinCodeCheck.PartiallySelected) {
      city.cityMarked = 1;
    } else {
      city.cityMarked = 0;
    }

    // check city
    if (isAllCityChecked(pinCode) == PinCodeCheck.AllSelected) {
      pinCode.stateMarked = 2;
    } else if (isAllCityChecked(pinCode) == PinCodeCheck.PartiallySelected) {
      pinCode.stateMarked = 1;
    } else {
      pinCode.stateMarked = 0;
    }
    if (!storeOnlineCtrl.isClosed) storeOnlineCtrl.sink.add(true);
  }

// endregion

// region isAllCityChecked
  PinCodeCheck isAllCityChecked(PinCode pinCode) {
    int unSelectedCounter = 0;
    int selectedCounter = 0;

    for (var cityPinCode in pinCode.cities!) {
      if (cityPinCode.cityMarked == 0) unSelectedCounter++;
      if (cityPinCode.cityMarked == 2) selectedCounter++;
    }
    if (selectedCounter == pinCode.cities!.length) return PinCodeCheck.AllSelected;
    if (unSelectedCounter < pinCode.cities!.length) return PinCodeCheck.PartiallySelected;

    return PinCodeCheck.NoneSelected;
  }

// endregion

// region Check state
  PinCodeCheck isAllPinCodeChecked(Cities cities) {
    int unSelectedCounter = 0;
    int selectedCounter = 0;

    for (var cityPinCode in cities.pincodes!) {
      if (cityPinCode.pincodeMarked == 0) unSelectedCounter++;
      if (cityPinCode.pincodeMarked == 2) selectedCounter++;
    }
    if (selectedCounter == cities.pincodes!.length) return PinCodeCheck.AllSelected;
    if (unSelectedCounter < cities.pincodes!.length) return PinCodeCheck.PartiallySelected;

    return PinCodeCheck.NoneSelected;
  }

// endregion

// region stateFullSelect
  void stateFullSelect(PinCode pinCode) {
    var data = pinCodeResponse.pinCode!.firstWhere((element) => element.state == pinCode.state);
    data.stateMarked = 2;
    for (var city in data.cities!) {
      city.cityMarked = data.stateMarked;
      for (var pincode in city.pincodes!) pincode.pincodeMarked = 2;
    }

    if (!storeOnlineCtrl.isClosed) storeOnlineCtrl.sink.add(true);
  }

// endregion

// region cityFullSelect
  void cityFullSelect(Cities cities, PinCode pinCode) {
    cities.cityMarked = 2;
    for (var pincode in cities.pincodes!) pincode.pincodeMarked = 2;

    // check city
    if (isAllCityChecked(pinCode) == PinCodeCheck.AllSelected) {
      pinCode.stateMarked = 2;
    } else if (isAllCityChecked(pinCode) == PinCodeCheck.PartiallySelected) {
      pinCode.stateMarked = 1;
    } else {
      pinCode.stateMarked = 0;
    }

    if (!storeOnlineCtrl.isClosed) storeOnlineCtrl.sink.add(true);
  }

// endregion

// region submit
  void submit() {
    selectedPinCodes.clear();
    for (var state in pinCodeResponse.pinCode!) {
      for (var city in state.cities!) {
        for (var pinCodes in city.pincodes!) {
          if (pinCodes.pincodeMarked == 2)
            // if(selectedPinCodes.contains(pinCodes.pincode!)){
            //   selectedPinCodes.remove(pinCodes.pincode!);
            // }
            selectedPinCodes.add(pinCodes.pincode!);
        }
      }
    }

    print(selectedPinCodes);
  }

// endregion
}
