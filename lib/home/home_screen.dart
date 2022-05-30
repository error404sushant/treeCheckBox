import 'dart:math';

import 'package:exparement/home/home_bloc.dart';
import 'package:exparement/model/pin_code_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_pro/flutter_tree_pro.dart';

// region Buyer HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
// endregion

class _HomeScreenState extends State<HomeScreen> {
  // region Bloc
  late HomeBloc homeBloc;

  // endregion

  // region Init
  @override
  void initState() {
    homeBloc = HomeBloc(context);
    homeBloc.init();
    super.initState();
  }

  // endregion

  // region build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body()),
    );
  }

  // endregion

  // region Body
  Widget body() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 9),
            child: StreamBuilder<bool>(
                stream: homeBloc.storeOnlineCtrl.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("${homeBloc.pinCodeResponse.pinCode![index].state}"),
                              (homeBloc.pinCodeResponse.pinCode![index].stateMarked == 1)
                                  ? Container(
                                      color: Colors.grey,
                                      height: 30,
                                      width: 30,
                                      child: CupertinoButton(
                                        padding: EdgeInsets.zero,
                                          onPressed: ()=> homeBloc.stateFullSelect(homeBloc.pinCodeResponse.pinCode![index]),
                                          child: Text("-")),
                                    )
                                  : Checkbox(
                                      value: homeBloc.pinCodeResponse.pinCode![index].stateMarked == 2,
                                      onChanged: (value) => homeBloc.onChangeState(homeBloc.pinCodeResponse.pinCode![index]))
                            ],
                          ),
                          city(homeBloc.pinCodeResponse.pinCode![index])
                        ],
                      );
                    },
                    itemCount: homeBloc.pinCodeResponse.pinCode!.length,
                  );
                }),
          ),
        ),
        submit(),
        clear(),
      ],
    );
  }

// endregion

// region city
  Widget city(PinCode pinCode) {
    return Visibility(

      visible: pinCode.isVisible!,
      child: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Text("${pinCode.cities![index].city}"),
                    pinCode.cities![index].cityMarked == 1
                        ? Container(
                      color: Colors.grey,
                      height: 30,
                      width: 30,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                          onPressed: ()=>  homeBloc.cityFullSelect(pinCode.cities![index], pinCode),
                          child: Text("-")),
                    )
                        :
                    Checkbox(
                        value: pinCode.cities![index].cityMarked == 2,
                        onChanged: (value) => homeBloc.onChangeCity(pinCode.cities![index], pinCode))
                  ],
                ),
                pinCodeList(pinCode.cities![index].pincodes!, pinCode.cities![index], pinCode)
              ],
            );
          },
          itemCount: pinCode.cities!.length,
        ),
      ),
    );
  }
// endregion


//region Pin code
  Widget pinCodeList(List<Pincodes> pinCodes, Cities city, PinCode pinCode) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text("${pinCodes[index].pincode}"),
              Checkbox(
                  value: pinCodes[index].pincodeMarked == 2,
                  onChanged: (value) => homeBloc.onChangePinCode(pinCodes[index], city, pinCode))
            ],
          );
        },
        itemCount: pinCodes.length,
      ),
    );
  }

//endregion

//region Submit
Widget submit(){
    return CupertinoButton(child: Text("Submit"), onPressed: (){
      homeBloc.submit();
    });
}
//endregion
// region Submit
Widget clear(){
    return CupertinoButton(child: Text("Clear"), onPressed: (){
      homeBloc.selectedPinCodes.clear();
    });
}
//endregion








}
