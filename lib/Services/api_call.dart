import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:navi_doc/Model/Category.dart';
import 'package:navi_doc/Model/CityDetails.dart';
import 'package:navi_doc/Model/DegreeDetials.dart';
import 'package:navi_doc/Model/DistrictDetails.dart';
import 'package:navi_doc/Model/Hospitals.dart';
import 'package:navi_doc/Model/OtpDetails.dart';
import 'package:navi_doc/Model/ProcedureDetails.dart';
import 'package:navi_doc/Model/Results.dart';
import 'package:navi_doc/Model/Results1.dart';
import 'package:navi_doc/Model/SpecialityDetails.dart';
import 'package:navi_doc/Model/StateDetails.dart';
import 'package:navi_doc/Model/SummaryReports.dart';
import 'package:navi_doc/Model/UserInfo.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/Model/WorkRecord.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Results1?> submitRegistrationData(UserInfo userInfo) async {
  try{
  var response = await http.post(Uri.http('15.206.64.192:8081', 'NaviDocServices/UserInfo/CreateUserInfo'),
      headers: {"Content-Type": "application/json"},
      body: userInfoToJson(userInfo));
  if (response.statusCode == 200){
    String responseString = response.body;
    return Results1.fromJson(json.decode(responseString));
  }
  else{
    return null;
  }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}


Future<Results1?> sendOtpData(String EmailId,String PhoneNumber, String LoginName) async {
  OtpDetails otpDetails = OtpDetails(OtpId: 0, UserId: 0, EmailId: EmailId, MobileNo: PhoneNumber, Otp: "", IfOtpUsed: 0,
      CreatedBy: "", CreatedOn: "", UpdatedBy: "", UpdatedOn: "", AdminId: 0, UserName: LoginName);
  try {
    var response = await http.post(
        Uri.http('15.206.64.192:8081', 'NaviDocServices/UserLogin/SendOtp'),
        headers: {"Content-Type": "application/json"},
        body: otpDetailsToJson(otpDetails));
    if (response.statusCode == 200) {
      String responseString = response.body;

      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}


Future<Results1?> verifyOtpData(String EmailId,String PhoneNumber, String Otp) async {
  OtpDetails otpDetails = OtpDetails(OtpId: 0, UserId: 0, EmailId: EmailId, MobileNo: PhoneNumber, Otp: Otp, IfOtpUsed: 0, CreatedBy: "",
      CreatedOn: "", UpdatedBy: "", UpdatedOn: "", AdminId: 0, UserName: "");
  try {
    var response = await http.post(
        Uri.http('15.206.64.192:8081', 'NaviDocServices/UserLogin/VerifyOtp'),
        headers: {"Content-Type": "application/json"},
        body: otpDetailsToJson(otpDetails));
    if (response.statusCode == 200) {
      String responseString = response.body;

      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<Results1?> loginData(String username,String password) async {
  UserLogin userLogin = UserLogin(Id: 0, Userinfo_id: 0, Username: username,
      Password: password, Token: "", Status: 0);
  try {
    var response = await http.post(
        Uri.http('15.206.64.192:8081', 'NaviDocServices/UserLogin/Login'),
        headers: {"Content-Type": "application/json"},
        body: userLoginToJson(userLogin));
    if (response.statusCode == 200) {
      String responseString = response.body;

      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<Results1?> forgotPasswordData(String email) async {
  try {
    UserLogin userLogin = UserLogin(Id: 0,
        Userinfo_id: 0,
        Username: "",
        Password: "",
        Token: "",
        Status: 0);
    UserInfo userInfo = UserInfo(Id: 0,
        Name: "",
        Surname: "",
        Speciality: "",
        Degree: "",
        MobileNo: "",
        Address: "",
        District: "",
        City: "",
        State: "",
        PinCode: "",
        Email_id: email,
        Date_of_birth: "",
        userLogin: userLogin);
    var response = await http.post(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/UserLogin/ForgotPassword'),
        headers: {"Content-Type": "application/json"},
        body: userInfoToJson(userInfo));
    if (response.statusCode == 200) {
      String responseString = response.body;

      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<Results1?> submitHospitalData(Hospitals hospitals,String token) async {
  try {
    var response = await http.post(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/Hospital/SaveHospitalDetails'),
        headers: {"Content-Type": "application/json",
          "SessionToken": token},
        body: hospitalsToJson(hospitals));
    if (response.statusCode == 200) {
      String responseString = response.body;
      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<Results1?> updateHospitalData(Hospitals hospitals,String token) async {
  try {
    var response = await http.post(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/Hospital/UpdateHospitalDetails'),
        headers: {"Content-Type": "application/json",
          "SessionToken": token},
        body: hospitalsToJson(hospitals));
    if (response.statusCode == 200) {
      String responseString = response.body;
      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<Hospitals>> getHospitalData(BuildContext context) async {
  // Common.buildShowDialog(context);
  final prefs = await SharedPreferences.getInstance();
  UserLogin userLogin = userLoginFromJson(prefs.getString("UserLogin")!);
  List<Hospitals> hospitalList = [];
  var queryParams = {
    'userId': userLogin.Userinfo_id.toString(),
  };
  var response = await http.get(Uri.http('15.206.64.192:8081', 'NaviDocServices/Hospital/GetHospitalDetails', queryParams)
      , headers: {"Content-Type": "application/json",
        "SessionToken": userLogin.Token});

  if (response.statusCode == 200) {
    String responseString = response.body;
    Results results = Results.fromJson(jsonDecode(responseString));

    try {
      if (results.success) {
        hospitalList = results.Result
            .map((item) => Hospitals.fromJson(item))
            .toList();
      }
    }catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  return hospitalList;

}

Future<Results1?> submitWorkRecordData(WorkRecord workRecord, String token) async {
  try {
    var response = await http.post(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/WorkRecord/SaveWorkRecord'),
        headers: {"Content-Type": "application/json",
          "SessionToken": token},
        body: workRecordToJson(workRecord));
    if (response.statusCode == 200) {
      String responseString = response.body;
      return Results1.fromJson(json.decode(responseString));
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<Results1?> updateWorkRecordData(WorkRecord workRecord,String token) async {
  try{
    var response = await http.post(Uri.http('15.206.64.192:8081', 'NaviDocServices/WorkRecord/UpdateWorkRecord'),
      headers: {"Content-Type": "application/json",
        "SessionToken": token},
      body: workRecordToJson(workRecord));
  if (response.statusCode == 200){
    String responseString = response.body;
    return Results1.fromJson(json.decode(responseString));
  }
  else{
    return null;
  }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<WorkRecord>> getWorkRecordData(BuildContext context) async {
  // Common.buildShowDialog(context);
  final prefs = await SharedPreferences.getInstance();
  UserLogin userLogin = userLoginFromJson(prefs.getString("UserLogin")!);
  List<WorkRecord> workRecordList = [];
  var queryParams = {
    'userId': userLogin.Userinfo_id.toString(),
    'AdminId': userLogin.Userinfo_id.toString(),
  };
  var response = await http.get(Uri.http('15.206.64.192:8081', 'NaviDocServices/WorkRecord/GetWorkRecords', queryParams)
      , headers: {"Content-Type": "application/json",
        "SessionToken": userLogin.Token});

  if (response.statusCode == 200){
    String responseString = response.body;
    Results results = Results.fromJson(jsonDecode(responseString));

try {
  if (results.success) {
    workRecordList = results.Result
        .map((item) => WorkRecord.fromJson(item))
        .toList();
  }
}
catch(e){
  Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
  }
  workRecordList.length;
  return workRecordList;
}

Future<List<StateDetails>?> getStatesData(BuildContext context) async {
  //Common.buildShowDialog(context);
  try {
    var response = await http.get(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/StatesMaster/GetStates'));
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<StateDetails> stateList = results.Result
          .map((item) => StateDetails.fromJson(item))
          .toList();
      //Common.hideDialog(context);
      return stateList;
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

Future<List<DegreeDetails>?> getDegreeData(BuildContext context) async {
  //Common.buildShowDialog(context);
  try {
    var response = await http.get(Uri.http('15.206.64.192:8081',
        'NaviDocServices/DegreeDetails/GetDegreeDetails'));
    //var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<DegreeDetails> degreeList = results.Result
          .map((item) => DegreeDetails.fromJson(item))
          .toList();

      //Common.hideDialog(context);
      return degreeList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<DistrictDetails>?> getDistrictData(BuildContext context) async {
  //Common.buildShowDialog(context);
  try {
    var response = await http.get(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/District/GetDistrictsList'));
    //var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<DistrictDetails> districtList = results.Result
          .map((item) => DistrictDetails.fromJson(item))
          .toList();
      //Common.hideDialog(context);
      return districtList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<CityDetails>?> getCityData(BuildContext context) async {
  //Common.buildShowDialog(context);
  try {
    var response = await http.get(
        Uri.http('15.206.64.192:8081', '/NaviDocServices/City/GetCitiesList'));
    //var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<CityDetails> cityList = results.Result
          .map((item) => CityDetails.fromJson(item))
          .toList();
      //Common.hideDialog(context);
      return cityList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<SpecialityDetails>?> getSpecialityData(BuildContext context, int degreeId) async {
  //Common.buildShowDialog(context);
  try {
    var queryParams = {
      'degreeId': degreeId.toString(),
    };

    var response = await http.get(
        Uri.http('15.206.64.192:8081', '/NaviDocServices/'
            'SpecialityDetails/GetSpecialityDetails', queryParams));

    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<SpecialityDetails> specialityList = results.Result
          .map((item) => SpecialityDetails.fromJson(item))
          .toList();
      //Common.hideDialog(context);
      return specialityList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<String>?> getHospitalOptions(BuildContext context) async {
  //Common.buildShowDialog(context);
  try {
    var response = await http.get(Uri.http(
        '15.206.64.192:8081', 'NaviDocServices/Hospital/GetDistinctHospitals'));
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<String> hospitalOptions = results.Result
          .map((item) => item.toString())
          .toList();

      //Common.hideDialog(context);
      return hospitalOptions;
    }
    else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<Category>?> getCategoryData(BuildContext context) async {
  //Common.buildShowDialog(context);
  try {
    var response = await http.get(Uri.http('15.206.64.192:8081',
        'NaviDocServices/CategoryDetails/GetCategoryDetails'));
    //var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<Category> categoryList = results.Result
          .map((item) => Category.fromJson(item))
          .toList();

      //Common.hideDialog(context);
      return categoryList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<ProcedureDetails>?> getProcedureDetailsData(BuildContext context, int categoryId) async {
  //Common.buildShowDialog(context);
  try {
    var queryParams = {
      'categoryId': categoryId.toString(),
    };

    var response = await http.get(Uri.http('15.206.64.192:8081',
        'NaviDocServices/ProcedureDetails/GetProcedureDetails',
        queryParams));

    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<ProcedureDetails> procedureList = results.Result
          .map((item) => ProcedureDetails.fromJson(item))
          .toList();
      //Common.hideDialog(context);
      return procedureList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<List<SummaryReports>?> getSummaryReportData(BuildContext context, String fromDate, String toDate) async {
  //Common.buildShowDialog(context);
  try {
    final prefs = await SharedPreferences.getInstance();
    UserLogin userLogin = userLoginFromJson(prefs.getString("UserLogin")!);

    var queryParams = {
      'UserId': userLogin.Userinfo_id.toString(),
      'fromDate': fromDate,
      'toDate': toDate,

    };
    var response = await http.get(Uri.http('15.206.64.192:8081',
        '/NaviDocServices/WorkRecord/GetBillDetailsForUser', queryParams),
        headers: {"Content-Type": "application/json",
          "SessionToken": userLogin.Token});
    //var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Results results = Results.fromJson(jsonDecode(response.body));

      List<SummaryReports> summaryList = results.Result
          .map((item) => SummaryReports.fromJson(item))
          .toList();

      //Common.hideDialog(context);
      return summaryList;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

Future<Results1?> getMailReportData(BuildContext context, String fromDate, String toDate) async {
  //Common.buildShowDialog(context);
  try {
    final prefs = await SharedPreferences.getInstance();
    UserLogin userLogin = userLoginFromJson(prefs.getString("UserLogin")!);

    var queryParams = {
      'UserId': userLogin.Userinfo_id.toString(),
      'fromDate': fromDate,
      'toDate': toDate,

    };
    var response = await http.get(Uri.http('15.206.64.192:8081',
        'NaviDocServices/WorkRecord/SendEmailForWorkDetails', queryParams),
        headers: {"Content-Type": "application/json",
          "SessionToken": userLogin.Token});
    //var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Results1 results = Results1.fromJson(jsonDecode(response.body));

      // List<SummaryReports> summaryList = results.Result
      //     .map((item) => SummaryReports.fromJson(item))
      //     .toList();

      //Common.hideDialog(context);
      return results;
    } else {
      return null;
    }
  }catch(e){
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
