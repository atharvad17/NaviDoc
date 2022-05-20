import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:navi_doc/Model/AmountReceived.dart';
import 'package:navi_doc/Model/Category.dart';
import 'package:navi_doc/Model/Hospitals.dart';
import 'package:navi_doc/Model/ProcedureDetails.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/Model/WorkRecord.dart';
import 'package:navi_doc/Services/api_call.dart';
import 'package:navi_doc/Services/common.dart';
import 'package:navi_doc/work_records_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWorkRecordScreen extends StatefulWidget {
  WorkRecord? workRecord;
  bool flag;
  AddWorkRecordScreen({Key? key, required this.workRecord, required this.flag}) : super(key: key);

  @override
  _AddWorkRecordScreenState createState() => _AddWorkRecordScreenState(workRecord, flag);
}

class _AddWorkRecordScreenState extends State<AddWorkRecordScreen> {
  WorkRecord? workRecord;
  bool flag;
  _AddWorkRecordScreenState(this.workRecord, this.flag);

  final GlobalKey<FormState> _addWorkRecordKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  TextEditingController dueDateinput = TextEditingController();
  List<Hospitals> hospitalDropDownList = [];
  List<Category> categoryDropDownList = [];
  List<ProcedureDetails> procedureDropDownList = [];
  //var patientSexList = ['Male', 'Female', 'Other'];
  String? currentHospitalItem, currentCategoryItem, currentPatientSexItem, currentProcedureItem;
  String? otherProcedure;
  String? workDetailValue, _workDetail, nameValue, _name, chargeValue, _charge, notesValue = "", _notes, categoryValue, _category, ageValue, _age;
  TextEditingController timeStartInput = TextEditingController();
  TextEditingController timeEndInput = TextEditingController();
  String? _radioValue = "Male", paymentDays, dueDateValue, formattedDate;
  int currentHospitalItemId = 0, currentCategoryItemId = 0;
  late AmountReceived amountReceived;
  late List<AmountReceived> AmountReceivedDetails;
  late DateTime date;
  ProcedureDetails procedureDetails = ProcedureDetails(Id: 0, AdminId: 0, CategoryId: 0, ProcedureName: 'Other', Active: 1, CreatedBy: "", CreatedOn: "", UpdatedBy: "", UpdatedOn: "");

  Widget _buildDetail(){
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
        enabled: flag,
        initialValue: workDetailValue,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Consultation/Procedure Detail'),
        onChanged: (text) {
          workDetailValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Procedure Detail is Required';
          }
          return null;
        },
        onSaved: (value) {
          _workDetail = value!;
        },
      ),
    );
  }

  Widget _buildName() {
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
        enabled: flag,
        initialValue: nameValue,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Patient Name'),
        onChanged: (text) {
          nameValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Patient Name is Required';
          }
          return null;
        },
        onSaved: (value) {
          _name = value!;
        },
      ),
    );
  }

  Widget _buildAmountCharged(){
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
        enabled: flag,
        initialValue: chargeValue,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Amount Charged'),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          chargeValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Amount Charged is Required';
          }
          return null;
        },
        onSaved: (value) {
          _charge = value!;
        },
      ),
    );
  }

  Widget _buildAge(){
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
        enabled: flag,
        initialValue: ageValue,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Patient Age'),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          ageValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Patient Age is Required';
          }
          return null;
        },
        onSaved: (value) {
          _age = value!;
        },
      ),
    );
  }

  Widget _buildNotes(){
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
        initialValue: notesValue,
        enabled: flag,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Notes (optional)'),
        onChanged: (text) {
          notesValue = text;
        },
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Notes is Required';
        //   }
        //   return null;
        // },
        // onSaved: (value) {
        //   _notes = value!;
        // },
      ),
    );
  }

  Widget _buildCategory(){
     return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('Category', style: TextStyle(
          color: Colors.black
        ),),
        value: currentCategoryItem,
        validator: (value) {
          if (value == null) {
            return 'Category is Required';
          }
          return null;
        },
        onChanged: flag? (newValue) {
          setState(() {
            //currentItem = newValue.toString();
            currentCategoryItem = newValue.toString();
            currentProcedureItem = null;
            currentCategoryItemId =  categoryDropDownList.where((i) =>
            i.CategoryName == newValue.toString()
            ).first.Id;

            //districtDropDownList.clear();

            getProcedureDetailsData(context, currentCategoryItemId).then((value) =>
            {
              setState(() {
                procedureDropDownList.clear();
                procedureDropDownList.addAll(value!);
                procedureDetails.CategoryId = currentCategoryItemId;
                procedureDropDownList.add(procedureDetails);
              })
            });

          });
        }: null,
        items: categoryDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.CategoryName),
            value: newValue.CategoryName,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOtherCategoryDetail(){
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
        enabled: flag,
        initialValue: otherProcedure,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Other Procedure'),
        onChanged: flag? (text) {
          otherProcedure = text;
        }: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Procedure is Required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildProcedureDetail(){
    return  Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text('Procedure', style: TextStyle(
          color: Colors.black
        ),),
        value: currentProcedureItem,
        validator: (value) {
          if (value == null) {
            return 'Procedure is Required';
          }
          return null;
        },
        onChanged: flag? (newValue) {
          setState(() {
            //currentItem = newValue.toString();
            currentProcedureItem = newValue.toString();

          });
        } : null,
        items: procedureDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.ProcedureName),
            value: newValue.ProcedureName,
          );
        }).toList(),
      ),
    );
  }

  // Widget _buildSurgeryDate(){
  //   return Container(
  //     child: TextField(
  //       controller: dateinput,
  //       decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
  //           labelText: "Consultation/Procedure Date"
  //       ),
  //       enabled: flag,
  //       readOnly: true,
  //       // validator: (value) {
  //       //   if (value == null) {
  //       //     return 'Procedure Date is Required';
  //       //   }
  //       //   return null;
  //       // },
  //       onTap: () async {
  //         DateTime? pickedDate = await showDatePicker(
  //             context: context,
  //             initialDate: DateTime.now(),
  //             firstDate: DateTime(1960),
  //             lastDate: DateTime.now()
  //         );
  //         if(pickedDate != null ){
  //           print(pickedDate);
  //           formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
  //
  //           setState(() {
  //             dateinput.text = formattedDate!;
  //             date = DateTime.now();
  //           });
  //         }else{
  //           print("Date is not selected");
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildSurgeryDate(){
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
        enabled: flag,
        controller: dateinput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Consultation/Procedure Date',),
        onTap: () async {
          await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1960),
            lastDate: DateTime.now(),
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

  Widget _buildStartTime(){
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
      child: TextField(
        controller: timeStartInput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
            labelText: "Start Time" //label text of field
        ),
        enabled: flag,
        readOnly: true,
        onTap: () async {
          try {
          TimeOfDay? pickedTime =  await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

            if (pickedTime != null) {
              setState(() {
                timeStartInput.text = pickedTime.hour.toString().padLeft(2, '0')+":"+pickedTime.minute.toString().padLeft(2, '0');
              });
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
        },
      ),
    );
  }

  Widget _buildEndTime(){
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
      child: TextField(
        controller: timeEndInput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
            labelText: "End Time" //label text of field
        ),
        enabled: flag,
        readOnly: true,
        onTap: () async {
          try {
          TimeOfDay? pickedTime =  await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

  if (pickedTime != null) {
      setState(() {
        timeEndInput.text = pickedTime.hour.toString().padLeft(2, '0')+":"+pickedTime.minute.toString().padLeft(2, '0');
      });
  } else {
      print("Time is not selected");
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
}},
      ),
    );
  }

  Widget _buildHospital(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(

        isExpanded: true,
        hint: const Text('Hospital', style: TextStyle(color: Colors.black),),
        value: currentHospitalItem,
        validator:  (value) {
    if (value == null) {
    return 'Hospital is Required';
    }
    return null;
    },
        onChanged: flag? (newValue) {
          setState(() {
            //currentItem = newValue.toString();
            try {
              currentHospitalItem = newValue.toString();
              Hospitals hospitals = hospitalDropDownList.where((i) =>
              i.Name ==  currentHospitalItem
              ).first;
              currentHospitalItemId =hospitals.Id;

              paymentDays = hospitals.Payment_day;

              date = DateFormat("dd-MM-yyyy").parseStrict(
                  dateinput.text.toString());
              DateFormat('yyyy-MM-dd').format(date);

              if (paymentDays == 'Immediate') {
                date = date.add(const Duration(days: 0));
              } else {
                date = date.add(Duration(days: int.parse(paymentDays!)));
              }

              dueDateValue = DateFormat('dd-MM-yyyy').format(date);
              dueDateinput.text = dueDateValue.toString();
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
        } : null,
        items: hospitalDropDownList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.Name),
            value: newValue.Name,
          );
        }).toList(),
      ),
    );
  }


  Widget _buildDueDate(){
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
      child: TextField(
        controller: dueDateinput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
            labelText: "Due Date" //label text of field
        ),
        enabled: flag,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1960),
              lastDate: DateTime(2030)
          );
          try {
            if (pickedDate != null) {
              String formattedDate = DateFormat('dd-MM-yyyy').format(
                  pickedDate);

              setState(() {
                dueDateinput.text = formattedDate;
              });
            } else {
              Fluttertoast.showToast(
                  msg: "Date is not selected",
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
        },
      ),
    );
  }

  Widget _buildPatientSex(){
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
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10,),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Text("Patient Sex", style: TextStyle(
                fontSize: 16, color: Colors.black,
            ),),
          ),
          Row(
            children: <Widget>[
              Radio(value: "Male", groupValue: _radioValue, onChanged: flag? (value){
                setState(() {
                  _radioValue = value as String;
                });
              }: null ),
              const SizedBox(width: 10.0,),
              const Text("Male"),

            ],
          ),
          Row(
            children: <Widget>[
              Radio(value: "Female", groupValue: _radioValue, onChanged: flag ?(value){
                setState(() {
                  _radioValue = value as String;
                });
              }: null ),
              const SizedBox(width: 10.0,),
              const Text("Female"),

            ],
          ),
          Row(
            children: <Widget>[
              Radio(value: "Other", groupValue: _radioValue, onChanged: flag? (value){
                setState(() {
                  _radioValue = value as String;
                });
              }: null),
              const SizedBox(width: 10.0,),
              const Text("Other"),
            ],
          ),
        ],
      ),
    );
  }
  Widget submitData(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
      ), onPressed: () async{
        if (timeStartInput.text == "" || timeEndInput.text == ""){
          Fluttertoast.showToast(
              msg: "Please enter Surgery Time",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if (dueDateinput.text == ""){
          Fluttertoast.showToast(
              msg: "Please Select Hospital",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
            if (_addWorkRecordKey.currentState!.validate()) {
              try {
                final prefs = await SharedPreferences.getInstance();

                UserLogin userLogin = userLoginFromJson(
                    prefs.getString("UserLogin")!);

                AmountReceivedDetails = [];
                WorkRecord workRecord = WorkRecord(Id: 0,
                    UserId: userLogin.Userinfo_id,
                    HospitalId: currentHospitalItemId,
                    AdminId: userLogin.Userinfo_id,
                    SurgeryDate: dateinput.text,
                    Category: currentCategoryItem.toString(),
                    CategoryId: currentCategoryItemId,
                    SurgeryDetail: workDetailValue.toString(),
                    SurgeryProcedure: currentProcedureItem.toString(),
                    AmountCharged: chargeValue.toString(),
                    Notes: notesValue.toString(),
                    DueDate: dueDateValue.toString(),
                    Status: 0,
                    FromTime: timeStartInput.text,
                    ToTime: timeEndInput.text,
                    PatientName: nameValue.toString(),
                    PatientSex: _radioValue.toString(),
                    PatientAge: ageValue.toString(),
                    OutstandingDays: 0,
                    CreatedBy: "",
                    CreatedOn: "",
                    UpdatedBy: "",
                    UpdatedOn: "",
                    HospitalName: currentHospitalItem.toString(),
                    amountReceived: null,
                    AmountReceivedDetails: AmountReceivedDetails);


                if(currentProcedureItem == "Other")
                  {
                    workRecord.SurgeryProcedure = otherProcedure!;
                  }
                workRecord.AdminId = userLogin.Userinfo_id;
                if (dateinput.text == null || dateinput.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Please enter Date of Birth",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }else{
                  var createdWorkRecord = await submitWorkRecordData(
                      workRecord, userLogin.Token);
                  Common.buildShowDialog(context);
                  if (createdWorkRecord!.success == true) {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("UserCategory", json.encode(createdWorkRecord.Result));
                    prefs.setString("UserHospital", currentHospitalItem.toString());

                    Common.hideDialog(context);
                    Fluttertoast.showToast(
                        msg: "Work Record Added Successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else {
                    Common.hideDialog(context);
                    Fluttertoast.showToast(
                        msg: createdWorkRecord.error,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                }
                _addWorkRecordKey.currentState!.reset();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WorkRecords()));
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

        }

      },
        child: const Text(
            'Submit'
        ),
      ),
    );
  }

  @override
  void initState() {
    timeStartInput.text = "";
    timeEndInput.text = "";
    Common.buildShowDialog(context);
    Future.wait([getHospitalData(context), getCategoryData(context)]).then((v) {
      var index = 0;
      for (var item in v) {
        if(index == 0)
        {
          setState(() {
            hospitalDropDownList.addAll((item as List<Hospitals>));
          });
        }
        else
        if(index == 1)
        {
            categoryDropDownList.addAll((item as List<Category>));
            if(workRecord != null) {
              currentCategoryItemId = categoryDropDownList.where((i) =>
              i.CategoryName == workRecord!.Category
              ).first.Id;

              getProcedureDetailsData(context, currentCategoryItemId).then((value) =>
              {
                setState(() {
                  procedureDropDownList.clear();
                  procedureDropDownList.addAll(value!);
                  procedureDetails.CategoryId = currentCategoryItemId;
                  procedureDropDownList.add(procedureDetails);
                })
              });
            }
        }

        index = index+1;
      }
    }).whenComplete(() {
      Common.hideDialog(context);
    });

    super.initState();

    dateinput.text = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    if (workRecord != null){
      dateinput.text = workRecord!.SurgeryDate;
      timeStartInput.text = workRecord!.FromTime;
      timeEndInput.text = workRecord!.ToTime;
      currentHospitalItem = workRecord!.HospitalName;
      currentCategoryItem = workRecord!.Category;
      currentProcedureItem = workRecord!.SurgeryProcedure;
      nameValue = workRecord!.PatientName;
      ageValue = workRecord!.PatientAge.toString();
      //this.currentPatientSexItem = this.workRecord!.patient_sex;
      workDetailValue = workRecord!.SurgeryDetail;
      chargeValue = workRecord!.AmountCharged.toString();
      dueDateinput.text = workRecord!.DueDate;
      notesValue = workRecord!.Notes;
      _radioValue = workRecord!.PatientSex;
    }
    else{
      WorkRecord w;
      String w1;
      SharedPreferences.getInstance().then((prefs) => {
       w = workRecordFromJson(prefs.getString("UserCategory")!),
        if(w != null)
          {
            currentCategoryItem = w.Category,

          },
        w1 = prefs.getString("UserHospital")!,
        if (w != null){
          currentHospitalItem = w1.toString(),
        }

      });


      }
  }

  Widget _buildHeader(){
    return Container(
        height: MediaQuery.of(context).size.height *0.07,
        color: Colors.indigo[900],
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width *0.2,
              child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,
                size: 28,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WorkRecords()), (route) => false);
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.6,
              child: const Text("\t\t\t\t\t\t\t\t\t\t\t\t\tWork Record", style: TextStyle(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Container(
              margin: const EdgeInsets.all(24),
              child: Form(
                key: _addWorkRecordKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildSurgeryDate(),
                    const SizedBox(height: 8,),
                    _buildStartTime(),
                    const SizedBox(height: 8,),
                    _buildEndTime(),
                    const SizedBox(height: 8,),
                    _buildHospital(),
                    const SizedBox(height: 8,),
                    _buildCategory(),
                    const SizedBox(height: 8,),
                    _buildProcedureDetail(),
                    const SizedBox(height: 8,),
                    Visibility(
                      visible: currentProcedureItem == 'Other',
                      child:_buildOtherCategoryDetail(),
                    ),
                    _buildDetail(),
                    const SizedBox(height: 8,),
                    _buildName(),
                    const SizedBox(height: 8,),
                    _buildAge(),
                    const SizedBox(height: 8,),
                    _buildPatientSex(),
                    const SizedBox(height: 8,),
                    _buildAmountCharged(),
                    const SizedBox(height: 8,),
                    _buildDueDate(),
                    const SizedBox(height: 8,),
                    _buildNotes(),
                    const SizedBox(height: 30,),
                    if(flag) submitData(),
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
