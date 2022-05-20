
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:navi_doc/Model/DegreeDetials.dart';
import 'package:navi_doc/Model/DistrictDetails.dart';
import 'package:navi_doc/Model/Results.dart';
import 'package:navi_doc/Model/SpecialityDetails.dart';
import 'package:navi_doc/Model/StateDetails.dart';
import 'package:navi_doc/Model/UserInfo.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/Services/common.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/CityDetails.dart';
import 'Services/api_call.dart';
import 'login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String terms =
      "  <p> By downloading or using the app NAVIDOC, these terms will automatically apply to you -" +
      "   you should make sure therefore that you read them carefully before using the app. " +
      "   You're not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. "+
      "   You're not allowed to attempt to extract the source code of the app, and you also shouldn't try to translate" +
      "   the app into other languages, or make derivative versions. The app itself, and all the trade marks, copyright, "+
      "   database rights and other intellectual property rights related to it, " +
      "   still belong to NAVIGO ANALYTIX LLP."+
      "</p>" +
      "<p>" +
      "    NAVIGO ANALYTIX LLP. is committed to ensuring that the app is as useful and efficient as possible. "+
      "   For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason."+
      "   We will charge you for the app usage or its services  making it very clear to you exactly how much you're paying for and what period."+
      "</p>" +
      "<p>" +
      "  Navidoc is not providing any advice of any kind in the app, and is merely helping you to ease your day to day activities related to your work and emoluments and tracking the same."+
      "  You may consult with your CAs for any further transaction related matters." +
      "  Your procedure and consultation history, details of the same and the emoluments/ reimbursements charged or received and otherwise has to be entered by users /may be provided by third parties, including other users of the service. "+
      "  Navidoc is not responsible for errors in the information or claims made by any advertiser in the app. "+
      "</p>" +
      "<p>&nbsp;</p>"+
      "<p>" +
      "   By signing the Terms and Conditions, you give your unconditional consent to store your personal data including"+
      "   emergency phone numbers in the app and your procedure/consultation details in the app. <br />"+
      "</p>" +
      "<p>" +
      "  The Navidoc app stores and processes personal data that you have provided to us, in order to provide our Service."+
      "   It's your responsibility to keep your phone and access to the app secure."+
      "   We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions"+
      "   and limitations imposed by the official operating system of your device. " +
      "   It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone's security features" +
      "   and it could mean that the Navidoc app won't work properly or at all."+
      "  </p>" +
      "   <p>"+
      "  You should be aware that there are certain things that NAVIGO ANALYTIX LLP. will not take responsibility for. " +
      "  Certain functions of the app will require the app to have an active internet connection." +
      "  The connection can be Wi-Fi, or provided by your mobile network provider, " +
      "  but NAVIGO ANALYTIX LLP. cannot take responsibility for the app not working at full functionality " +
      "   if you don't have access to Wi-Fi, and you don't have any of your data allowance left." +
      "  </p>"+
      "   <p>"+
      "    If you're using the app outside of an area with Wi-Fi,you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection whileaccessing the app, or other third party charges. In using the app, you&rsquo;re accepting responsibility for any such charges,including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you&rsquo;re using the app, please be aware that we assume that you have received permission from the bill payer for using the app."+
      "   </p>"+
      "   <p>" +"Along the same lines, NAVIGO ANALYTIX LLP cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged; if it runs out of battery and you can't turn it on to avail the Service, NAVIGO ANALYTIX LLP cannot accept responsibility."+
      "  </p>"+
      "  <p>"+
      "   With respect to NAVIGO ANALYTIX LLP & it's responsibility for your use of the app, when you are using the app, it's important to bear in mind that although we endeavour to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. NAVIGO ANALYTIX LLP accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app."+
      "   </p>"+
      "    <p>"+
      "   At some point, we may wish to update the app. The app is currently available on Android  the requirements for system (and for any additional systems we decide to extend the availability of the app to) may change, and you will need to download the updates if you want to keep using the app. Kindly download your reports every month and store the same.  NAVIGO ANALYTIX LLP Ltd. does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device."+
      "   </p>"+
      "   <p>" +
      "   <strong>" +
      "   Changes to This Terms and Conditions" +
      "  <strong>"+
      "   </p> "+
      "   <p>"+
      "   We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. These changes are effective immediately after they are posted on this page."+
      "  </p>"+
      "  <p>" +
      "  <strong>" +
      "  Contact Us"+
      "  </strong>"+
      "   </p>"+
      " <p>" +"If you have any questions or suggestions about our Terms and Conditions, do not hesitate to contact us at navidoc22@gmail.com."+
      "</p>";

  final GlobalKey<FormState> _registrationKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpKey = GlobalKey<FormState>();
  late String firstNameValue, lastNameValue, addressValue, loginNameValue, mobileNumberValue,  _firstName,
      _lastName, _mobileNumber, _email, _address, _loginNameVal, pinCodeValue,
      _passwordVal, _confirmPasswordVal, _pincode, emailIdValue, otpValue;
  List<SpecialityDetails> specialityDropDownList = [], specialityList = [];
  List<DegreeDetails> degreeDropDownList = [];
  List<StateDetails> stateDropDownList = [];
  List<DistrictDetails> districtDropDownList = [] , districtList = [];
  List<CityDetails> cityDropDownList = [], cityList = [];
  String? currentSpecialityItem, currentDegreeItem, currentStateItem, currentDistrictItem, currentCityItem;
  int currentStateItemId = 0,currentDistrictItemId = 0, currentDegreeItemId = 0;
  TextEditingController dateinput = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  late Results results;
  late UserInfo userInfo;
  late UserLogin userLogin;
  bool isChecked = false;

  Widget _buildFirstName() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        initialValue: 'Dr. ',
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'First Name',
        hintText: "First Name"),
        onChanged: (text) {
          firstNameValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'First Name is Required';
          }
          return null;
        },
        onSaved: (value) {
          _firstName = value!;
        },
      ),
    );
  }

  Widget _buildLastName() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Last Name',
        hintText: "Last Name"),
        onChanged: (text) {
          lastNameValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Last Name is Required';
          }
          return null;
        },
        onSaved: (value) {
          _lastName = value!;
        },
      ),
    );
  }

  Widget _buildMobileNumber() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Mobile number',
        hintText: "10 digit Mobile number"),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          mobileNumberValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Mobile number is Required';
          }
          if (value.length != 10){
            return 'Enter Appropriate Mobile Number';
          }
          return null;
        },
        onSaved: (value) {
          _mobileNumber = value!;
        },
      ),
    );
  }

  Widget _buildPincode() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Pincode',
        hintText: "6 digit Pincode"),
        keyboardType: TextInputType.phone,
        onChanged: (text){
          pinCodeValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pincode is Required';
          }
          if (value.length != 6){
            return 'Enter Appropriate Pincode';
          }
          return null;
        },
        onSaved: (value) {
          _pincode = value!;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Email',
        hintText: "Email Address"),
        onChanged: (text){
          emailIdValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email Address is Required';
          }
          if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email Address';
          }
          return null;
        },
        onSaved: (value) {
          _email = value!;
        },
      ),
    );
  }

  Widget _buildAddress() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Resident Address',
        hintText: "Flat/Building"),
        onChanged: (text) {
          addressValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Address is Required';
          }
          return null;
        },
        onSaved: (value) {
          _address = value!;
        },
      ),
    );
  }

  Widget _buildLoginName() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Preferred Login Name',
        hintText: "Preferred Login Name"),
        onChanged: (text) {
          loginNameValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Login Name is Required';
          }
          return null;
        },
        onSaved: (value) {
          _loginNameVal = value!;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Password',
        hintText: "Password"),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is Required';
          }
          if (value.length < 8){
            return 'Password should be of minimum 8 characters';
          }

          return null;
        },
        onChanged: (value) {
          _passwordVal = value;
        },
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Confirm Password',
        hintText: "Confirm Password"),
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is Required';
          }
          if (value == _passwordVal){
            // return 'Password Matching';
          }
          else{
            return 'Password is not matching';
          }

          return null;
        },
        // onChanged: (value) {
        //   _passwordVal = value;
        // },
      ),
    );
  }

  Widget _buildDegree(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('Degree', style: TextStyle(color: Colors.black),), // Not necessary for Option 1
        value: currentDegreeItem,
        validator: (value) {
          if (value == null) {
            return 'Degree is Required';
          }
          return null;
        },
        onChanged: (newValue) {
          setState(() {
            try {
              currentDegreeItem = newValue.toString();
              currentSpecialityItem = null;

              currentDegreeItemId = degreeDropDownList.where((i) =>
              i.Name == newValue.toString()
              ).first.Id;


              getSpecialityData(context, currentDegreeItemId).then((value) =>
              {
                setState(() {
                  specialityDropDownList.clear();
                  specialityDropDownList.addAll(value!);
                })
              });

              // specialityDropDownList = specialityList.where((i) =>
              // i.DegreeId == currentDegreeItem
              // ).toList();

            }catch(e){
              e.toString();
            }
          });
        },
        items: degreeDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.Name),
            value: newValue.Name,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpeciality(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('Speciality', style: TextStyle(color: Colors.black),), // Not necessary for Option 1
        value: currentSpecialityItem,
        validator: (value) {
          if (value == null) {
            return 'Speciality is Required';
          }
          return null;
        },
        onChanged: (newValue) {
          setState(() {
            try {
              //currentItem = newValue.toString();
              currentSpecialityItem = newValue.toString();
            }catch(e){Fluttertoast.showToast(
                msg: e.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );e.toString();
            }
          });
        },
        items: specialityDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.Speciality),
            value: newValue.Speciality,
          );
        }).toList(),
      ),
    );
  }

  // Widget _buildDOB(){
  //   DateTime date = DateTime.now().subtract(const Duration(days: 7300));
  //   // dateinput.text = DateFormat('dd-MM-yyyy').format(
  //   //     date).toString();
  //   return Container(
  //     child: TextField(
  //       controller: dateinput,
  //       decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
  //           labelText: "Date of Birth"//label text of field
  //       ),
  //       readOnly: true,
  //       // validator: (value) {
  //       //   if (value == null) {
  //       //     return 'Date of Birth is Required';
  //       //   }
  //       //   return null;
  //       // },
  //       onTap: () async {
  //
  //         DateTime? pickedDate = await showDatePicker(
  //             context: context,
  //             initialDate: date,
  //             firstDate: DateTime(1947),
  //             lastDate: date
  //         );
  //         try {
  //           if (pickedDate != null) {
  //             print(pickedDate);
  //             String formattedDate = DateFormat('dd-MM-yyyy').format(
  //                 pickedDate);
  //             print(formattedDate);
  //             setState(() {
  //               dateinput.text = formattedDate;
  //             });
  //           }
  //         }catch(e){
  //           Fluttertoast.showToast(
  //               msg: e.toString(),
  //               toastLength: Toast.LENGTH_SHORT,
  //               gravity: ToastGravity.BOTTOM,
  //               timeInSecForIosWeb: 1,
  //               textColor: Colors.white,
  //               fontSize: 16.0
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildDOB(){
    DateTime date = DateTime.now().subtract(const Duration(days: 7300));
    dateinput.text = DateFormat('dd-MM-yyyy').format(date).toString();
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        readOnly: true,
        controller: dateinput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Date of Birth',
        hintText: "Date of Birth"),
        onTap: () async {
          await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(1947),
            lastDate: date,
          ).then((selectedDate) {
            if (selectedDate != null) {
              dateinput.text = DateFormat('dd-MM-yyyy').format(selectedDate);
            }
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter date';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildState(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('State', style: TextStyle(color: Colors.black),),
        value: currentStateItem,
        validator: (value) {
          if (value == null) {
            return 'State is Required';
          }
          return null;
        },
        onChanged: (newValue) {
            setState(() {
try {
  currentStateItem = newValue.toString();
  currentDistrictItem = null;
  currentCityItem = null;
  currentStateItemId = stateDropDownList.where((i) =>
  i.StateName == newValue.toString()
  ).first.StateId;

  //districtDropDownList.clear();
  districtDropDownList = districtList.where((i) =>
  i.StateId == currentStateItemId
  ).toList();
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
            });
        },
        items: stateDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.StateName),
            value: newValue.StateName,
          );
        }).toList(),
      ),
    );
  }



  Widget _buildDistrict(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('District', style: TextStyle(color: Colors.black),), // Not necessary for Option 1
        value: currentDistrictItem,
        validator: (value) {
          if (value == null) {
            return 'District is Required';
          }
          return null;
        },
        onChanged: (newValue) {
          setState(() {
try {
  currentDistrictItem = newValue.toString();
  currentCityItem = null;
  currentDistrictItemId = districtDropDownList.where((i) =>
  i.DistrictName == newValue.toString()
  ).first.DistrictId;

  cityDropDownList = cityList.where((i) =>
  i.StateId == currentStateItemId && i.DistrictId == currentDistrictItemId
  ).toList();
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
          });
        },
        items: districtDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.DistrictName),
            value: newValue.DistrictName,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCity(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('City', style: TextStyle(color: Colors.black),), // Not necessary for Option 1
        value: currentCityItem,
        validator: (value) {
          if (value == null) {
            return 'City is Required';
          }
          return null;
        },
        onChanged: (newValue) {
          setState(() {
            try {
              //currentItem = newValue.toString();
              currentCityItem = newValue.toString();
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
          });
        },
        items: cityDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.Name),
            value: newValue.Name,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSubmitBtn(){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
      ), onPressed: () async {
        if (_registrationKey.currentState!.validate()) {
          //_registrationKey.currentState!.reset();
          userLogin = UserLogin(Id: 0,
              Userinfo_id: 0,
              Username: loginNameValue,
              Password: _passwordVal,
              Token: "",
              Status: 0);

          userInfo = UserInfo(
              Id: 0,
              Name: firstNameValue.replaceAll("Dr.", "").trim(),
              Surname: lastNameValue,
              Speciality: currentSpecialityItem.toString(),
              Degree: currentDegreeItem.toString(),
              MobileNo: mobileNumberValue,
              Address: addressValue,
              District: currentDistrictItem.toString(),
              City: currentCityItem.toString(),
              State: currentStateItem.toString(),
              PinCode: pinCodeValue,
              Email_id: emailIdValue,
              Date_of_birth: dateinput.text,
              userLogin: userLogin);

          final prefs = await SharedPreferences.getInstance();
          prefs.setString("UserInfo", userInfoToJson(userInfo));
try {
  if (isChecked == false){
      Fluttertoast.showToast(
          msg: "Please Accept Terms and Conditions",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }
  else {
      // if (dateinput.text == null || dateinput.text.isEmpty){
      //   Fluttertoast.showToast(
      //       msg: "Please enter Date of Birth",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       textColor: Colors.white,
      //       fontSize: 16.0
      //   );
      // }
      //else{
        Common.buildShowDialog(context);
        var result = await sendOtpData(emailIdValue, mobileNumberValue, loginNameValue);

        if (result!.success == true) {
          Future.delayed(Duration.zero, () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: result.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: const Text('Verify OTP'),
                      content: Form(
                            key: _otpKey,
                            child: TextFormField(
                              onChanged: (text) {
                                otpValue = text;
                              },
                              controller: displayNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter OTP';
                                }
                                return null;
                              },
                            ),
                          ),
                      actions: <Widget>[
                        ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text('Cancel')),
                        ElevatedButton(
                          child: const Text('Submit OTP'),
                          onPressed: () async {
                            if (_otpKey.currentState!.validate()) {
                              // verify otp api
                              Common.buildShowDialog(context);
                              var otpResult =
                              await verifyOtpData(emailIdValue, mobileNumberValue, otpValue);

                              if (otpResult!.success == true) {
                                Future.delayed(Duration.zero, () {
                                  Navigator.pop(context);
                                  Common.buildShowDialog(context);
                                  submitRegistrationData(userInfo).then((
                                      createdUserData) =>
                                  {
                                    if (createdUserData!.success) {
                                      Future.delayed(Duration.zero, () {
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg: "Account Successfully Created",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );

                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginScreen()));
                                      })
                                    }
                                    else
                                      {
                                        Common.hideDialog(context),
                                        Fluttertoast.showToast(
                                            msg: createdUserData!.error,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        )
                                      }
                                  });
                                });
                              }
                              else {
                                Common.hideDialog(context);
                                Fluttertoast.showToast(
                                    msg: otpResult.error,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              _otpKey.currentState!.reset();
                            }
                          },
                        )
                      ],
                    ),
                  );
                }
            );
          });
        }
        else {
          Common.hideDialog(context);
          Fluttertoast.showToast(
              msg: result.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
   // }

  }
}catch(e){
  Common.hideDialog(context);
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
      },
          child: const Text('Submit'),
      ),
    );
  }

  Widget _buildTerms(){
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        const Text("I Accept", style: TextStyle(
            color: Colors.black,),),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(onPressed: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return WillPopScope(
                    onWillPop: () async => true,
                    child: AlertDialog(
                      backgroundColor: Colors.indigo[900],
                      title: const Text('Terms and Conditions', style: TextStyle(
                        color: Colors.white
                      ),),
                      content: SingleChildScrollView(
                        child: Html(data: terms,
                          defaultTextStyle: const TextStyle(
                              color: Colors.white,),
                          ),
                      )
                    ),
                  );
                }
            );
          },
              child: const Text('Terms and Conditions', style: TextStyle(
                  color: Colors.purple,
                  decoration: TextDecoration.underline,
              decorationColor: Colors.purple),
              )),
        ),
      ],
    );
  }




  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    Common.buildShowDialog(context);
    Future.wait([getDegreeData(context), getStatesData(context),getDistrictData(context),getCityData(context)]).then((v) {
      var index = 0;
      for (var item in v) {
       if(index == 0)
         {
           setState(() {
             degreeDropDownList.addAll((item as List<DegreeDetails>));
           });
         }
       else
       if(index == 1)
       {
         setState(() {
           stateDropDownList.addAll((item as List<StateDetails>));
         });
       }
       else if(index == 2)
         {
           districtList.addAll((item as List<DistrictDetails>));
         }
       else if(index == 3)
         {
           cityList.addAll((item as List<CityDetails>));
         }
       index = index+1;
      }
    }).whenComplete(() {
      Common.hideDialog(context);
    });


  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Registration Form'),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Form(
            key: _registrationKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildFirstName(),
                    const SizedBox(height: 8,),
                    _buildLastName(),
                    const SizedBox(height: 8,),
                    _buildDegree(),
                    const SizedBox(height: 8,),
                    _buildSpeciality(),
                    const SizedBox(height: 8,),
                    _buildMobileNumber(),
                    const SizedBox(height: 8,),
                    _buildAddress(),
                    const SizedBox(height: 8,),
                    _buildState(),
                    const SizedBox(height: 8,),
                    _buildDistrict(),
                    const SizedBox(height: 8,),
                    _buildCity(),
                    const SizedBox(height: 8,),
                    _buildPincode(),
                    const SizedBox(height: 8,),
                    _buildEmail(),
                    const SizedBox(height: 8,),
                    _buildDOB(),
                    const SizedBox(height: 8,),
                    _buildLoginName(),
                    const SizedBox(height: 8,),
                    _buildPassword(),
                    const SizedBox(height: 8,),
                    _buildConfirmPassword(),
                    const SizedBox(height: 8,),
                    _buildTerms(),
                    const SizedBox(height: 30,),
                    _buildSubmitBtn(),
                  ],
                ),
            ),
          ),
      ),
    );
  }
}
