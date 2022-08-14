class SignUpStep1Model {
  String? firstName;
  String? lastName;
  String? phone;

  SignUpStep1Model({this.firstName, this.lastName, this.phone});

  SignUpStep1Model.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    return data;
  }
}

class SignUpStep2Model {
  List<String>? codesms;
  String? phone;

  SignUpStep2Model({this.codesms, this.phone});

  SignUpStep2Model.fromJson(Map<String, dynamic> json) {
    codesms = json['codesms'].cast<String>();
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codesms'] = this.codesms;
    data['phone'] = this.phone;
    return data;
  }
}

class SignUpStep3Model {
  String? phone;
  List<String>? codesms;
  String? pass1;
  String? pass2;

  SignUpStep3Model({this.phone, this.codesms, this.pass1, this.pass2});

  SignUpStep3Model.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    codesms = json['codesms'].cast<String>();
    pass1 = json['pass1'];
    pass2 = json['pass2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['codesms'] = this.codesms;
    data['pass1'] = this.pass1;
    data['pass2'] = this.pass2;
    return data;
  }
}
