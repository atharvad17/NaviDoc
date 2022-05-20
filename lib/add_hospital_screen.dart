import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:navi_doc/Model/CityDetails.dart';
import 'package:navi_doc/Model/DistrictDetails.dart';
import 'package:navi_doc/Model/Hospitals.dart';
import 'package:navi_doc/Model/StateDetails.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/Services/api_call.dart';
import 'package:navi_doc/Services/common.dart';
import 'package:navi_doc/practice_information_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHospitalScreen extends StatefulWidget {
  //PracticeInformation? practice_information;
  Hospitals? hospital;
  AddHospitalScreen({Key? key, required this.hospital}) : super(key: key);

  @override
  _AddHospitalScreenState createState() => _AddHospitalScreenState(hospital);
}

class _AddHospitalScreenState extends State<AddHospitalScreen> {
  //PracticeInformation? practice_information;
  Hospitals? hospital;
  _AddHospitalScreenState(this.hospital);

  List<String> hospitalOptions = [];


  final GlobalKey<FormState> _addHospitalKey = GlobalKey<FormState>();
   String hospitalNameValue= "", departmentValue = "",
      contactPerson = "", mobileNumber = "", addressValue="", pinCodeValue = "";
  List<StateDetails> stateDropDownList = [];
  List<DistrictDetails> districtDropDownList = [] , districtList = [];
  List<CityDetails> cityDropDownList = [], cityList = [];
  var paymentDays = ['Immediate', '7', '15', '30', '45', '60'];
  String? currentStateItem, currentDistrictItem, currentCityItem, currentPaymentItem, createdBy;
  String? titleValue;
  int currentStateItemId = 0,currentDistrictItemId = 0, id = 0;
  late Hospitals hospitals;
  final TextEditingController _typeAheadController = TextEditingController();

  Widget _buildHospital() {
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
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: _typeAheadController,
            decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
                labelText: 'Hospital Name' ,
              hintText: "Hospital Name"
            )
        ),
        suggestionsCallback: (pattern) {
          hospitalNameValue = pattern.toString();
              return hospitalOptions.where((String option) {
                return option.toString().toLowerCase().contains(pattern.toString().toLowerCase());
              });
        },
        // noItemsFoundBuilder: (context) {
        //   return ListTile(
        //
        //   );
        // },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion.toString()),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          _typeAheadController.text = suggestion.toString();
          hospitalNameValue = _typeAheadController.text;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Hospital Name is Required';
          }
        },
        onSaved: (value) => hospitalNameValue = value!,
      ),
    );

    //   Autocomplete<String>(
    //
    //   optionsBuilder: (TextEditingValue textEditingValue) {
    //     if (textEditingValue.text == '') {
    //       return const Iterable<String>.empty();
    //     }
    //     hospitalNameValue = textEditingValue.text;
    //     return hospitalOptions.where((String option) {
    //       return option.contains(textEditingValue.text.toLowerCase());
    //     });
    //   },
    //
    //   onSelected: (String selection) {
    //     debugPrint('You just selected $selection');
    //     hospitalNameValue = selection;
    //   },
    // );



    //   TextFormField(
    //   initialValue: hospitalNameValue,
    //   decoration: InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Hospital Name'),
    //   onChanged: (text) {
    //     hospitalNameValue = text;
    //   },
    //   validator: (value) {
    //     if (value == null || value.isEmpty) {
    //       return 'Hospital Name is Required';
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     _hospitalName = value!;
    //   },
    // );
  }

  // Widget _buildDepartment() {
  //   return TextFormField(
  //     initialValue: departmentValue,
  //     decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Department'),
  //     onChanged: (text) {
  //       departmentValue = text;
  //     },
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Department is Required';
  //       }
  //       return null;
  //     },
  //   );
  // }

  Widget _buildContactPerson() {
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
        initialValue: contactPerson,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Contact Person',
        hintText: "Contact Person"),
        onChanged: (text) {
          contactPerson = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Contact Person is Required';
          }
          return null;
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
        initialValue: mobileNumber,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Mobile number of Contact',
        hintText: "10 digit Mobile Number"),
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Mobile number is Required';
          }
          if (value.length != 10){
            return 'Enter Appropriate Mobile Number';
          }
          return null;
        },
        onChanged: (text) {
          mobileNumber = text;
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
        hint: const Text('State', style: TextStyle(color: Colors.black),), // Not necessary for Option 1
        value: currentStateItem,
        validator: (value) {
    if (value == null) {
    return 'State is Required';
    }
    return null;
    },
        onChanged: (newValue) {
          setState(() {
            try{
            //currentItem = newValue.toString();
            currentStateItem = newValue.toString();
            currentDistrictItem = null;
            currentCityItem = null;
            currentStateItemId =  stateDropDownList.where((i) =>
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
              //currentItem = newValue.toString();
              currentDistrictItem = newValue.toString();
              currentCityItem = null;
              currentDistrictItemId = districtDropDownList.where((i) =>
              i.DistrictName == newValue.toString()
              ).first.DistrictId;

              cityDropDownList = cityList.where((i) =>
              i.StateId == currentStateItemId &&
                  i.DistrictId == currentDistrictItemId
              ).toList();
            }catch(e) {
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

  Widget _buildPaymentDays(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('Payment Days', style: TextStyle(color: Colors.black),), // Not necessary for Option 1
        value: currentPaymentItem,
        validator: (value) {
          if (value == null) {
            return 'Payment Days is Required';
          }
          return null;
        },
        onChanged: (newValue) {
          setState(() {
            try {
              //currentItem = newValue.toString();
              currentPaymentItem = newValue.toString();
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
        items: paymentDays.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue),
            value: newValue,
          );
        }).toList(),
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
        initialValue: addressValue,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Address',
        hintText: "Road/Landmark"),
        onChanged: (text) {
          addressValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Address is Required';
          }
          return null;
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
        initialValue: pinCodeValue,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Pincode (optional)',
        hintText: "6 digit Pincode"),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          pinCodeValue = text;
        },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Pincode is Required';
        //   }
        //   if (value.length != 6){
        //     return 'Enter Appropriate Pincode';
        //   }
        //   return null;
        // },
      ),
    );
  }

  Widget submitData(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
        primary: Colors.indigo[900],
      ), onPressed: () async {
        if (_addHospitalKey.currentState!.validate()){
          hospitals = Hospitals(Id: 0,
              Name: _typeAheadController.text,
              Address: addressValue,
              District: currentDistrictItem.toString(),
              Citys: currentCityItem.toString(),
              State: currentStateItem.toString(),
              Department: departmentValue,
              Contact_person: contactPerson,
              Mobile_of_contact: mobileNumber,
              Payment_day: currentPaymentItem.toString(),
              PinCode: pinCodeValue,
              AdminId: 0,
              CreatedBy: "",
              CreatedOn: "",
              UpdatedBy: "",
              UpdatedOn: "");

          final prefs = await SharedPreferences.getInstance();

          UserLogin userLogin = userLoginFromJson(prefs.getString("UserLogin")!);
          hospitals.AdminId = userLogin.Userinfo_id;

          if (titleValue == 'Edit Hospital'){
            hospitals.Id = id;
            hospitals.CreatedBy = createdBy!;
            try {
              var updatedHospital = await updateHospitalData(hospitals, userLogin.Token);
              Common.buildShowDialog(context);
              if (updatedHospital!.success == true) {
                Common.hideDialog(context);
                Fluttertoast.showToast(
                    msg: "Hospital Updated Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              } else {
                Common.hideDialog(context);
                Fluttertoast.showToast(
                    msg: updatedHospital.error,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
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
          }else{
            try {
              var createdHospital = await submitHospitalData(
                  hospitals, userLogin.Token);
              Common.buildShowDialog(context);
              if (createdHospital!.success == true) {
                Common.hideDialog(context);
                Fluttertoast.showToast(
                    msg: "Hospital Added Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              } else {
                Common.hideDialog(context);
                Fluttertoast.showToast(
                    msg: createdHospital.error,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
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

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PracticeInformationScreen()));
        }
      },
          child: const Text('Submit', style: TextStyle(
            color: Colors.white
          ),)
      ),
    );
  }


  @override
  void initState() {

    super.initState();
    Common.buildShowDialog(context);
    Future.wait([getStatesData(context),getDistrictData(context),getCityData(context), getHospitalOptions(context)]).then((v) {
      var index = 0;
      for (var item in v) {
        if(index == 0)
        {
          if (item!.isEmpty){
            Fluttertoast.showToast(
                msg: "Please try Again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else{
            setState(() {
              stateDropDownList.addAll((item as List<StateDetails>));
            });
          }

        }
        else if(index == 1) {
          try {
            districtList.addAll((item as List<DistrictDetails>));
           if(hospital != null) {
             currentStateItemId = stateDropDownList.where((i) =>
             i.StateName == hospital!.State
             ).first.StateId;

             //districtDropDownList.clear();
             districtDropDownList = districtList.where((i) =>
             i.StateId == currentStateItemId
             ).toList();
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
        else if(index == 2)
        {
          try {
            cityList.addAll((item as List<CityDetails>));
            if(hospital != null) {
              currentDistrictItemId = districtDropDownList.where((i) =>
              i.DistrictName == hospital!.District
              ).first.DistrictId;

              cityDropDownList = cityList.where((i) =>
              i.StateId == currentStateItemId &&
                  i.DistrictId == currentDistrictItemId
              ).toList();
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
        else if (index == 3){
            hospitalOptions.addAll((item as List<String>));
        }
        index = index+1;
      }
    }).whenComplete(() {
      Common.hideDialog(context);
    });

try {
  if (hospital != null) {
    titleValue = 'Edit Hospital';
    currentPaymentItem = hospital!.Payment_day;
    _typeAheadController.text = hospital!.Name;
    //this.departmentValue = this.hospital!.Department;
    mobileNumber = hospital!.Mobile_of_contact;
    contactPerson = hospital!.Contact_person;
    addressValue = hospital!.Address;
    pinCodeValue = hospital!.PinCode;
    id = hospital!.Id;
    currentStateItem = hospital!.State;
    currentDistrictItem = hospital!.District;
    currentCityItem = hospital!.Citys;
    createdBy = hospital!.CreatedBy;
  }
  else {
    titleValue = 'Add Hospital';
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

  Widget _buildHeader(){
    return Container(
        height: MediaQuery.of(context).size.height *0.07,
        color: Colors.green[900],
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *0.2,
              child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,
                size: 28,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PracticeInformationScreen()), (route) => false);
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.6,
              child: Text("\t\t\t\t\t\t\t\t\t\t\t\t\t "+titleValue!, style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        )

    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/navigo3.jpg', height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.width * 0.2,),
        automaticallyImplyLeading: false,
        elevation: 0,
        //title: Text(titleValue!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(24),
                  child: Form(
                    key: _addHospitalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildHospital(),
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
                        //_buildDepartment(),
                        _buildContactPerson(),
                        const SizedBox(height: 8,),
                        _buildMobileNumber(),
                        const SizedBox(height: 8,),
                        _buildPaymentDays(),
                        const SizedBox(height: 50,),
                        submitData(),
                      ],
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
