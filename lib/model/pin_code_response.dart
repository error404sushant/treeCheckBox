class PinCodeResponse {
  List<PinCode>? pinCode;

  PinCodeResponse({this.pinCode});

  PinCodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['pinCode'] != null) {
      pinCode = <PinCode>[];
      json['pinCode'].forEach((v) {
        pinCode!.add(new PinCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pinCode != null) {
      data['pinCode'] = this.pinCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PinCode {
  String? state;
  int? stateMarked;
  bool? isVisible = false;
  List<Cities>? cities;

  PinCode({this.state, this.stateMarked, this.cities}): isVisible = false;

  PinCode.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    stateMarked = json['stateMarked'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['stateMarked'] = this.stateMarked;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? city;
  int? cityMarked;
  List<Pincodes>? pincodes;

  Cities({this.city, this.cityMarked, this.pincodes});

  Cities.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    cityMarked = json['cityMarked'];
    if (json['pincodes'] != null) {
      pincodes = <Pincodes>[];
      json['pincodes'].forEach((v) {
        pincodes!.add(new Pincodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['cityMarked'] = this.cityMarked;
    if (this.pincodes != null) {
      data['pincodes'] = this.pincodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pincodes {
  int? pincode;
  int? pincodeMarked;

  Pincodes({this.pincode, this.pincodeMarked});

  Pincodes.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    pincodeMarked = json['pincodeMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pincode'] = this.pincode;
    data['pincodeMarked'] = this.pincodeMarked;
    return data;
  }
}
