import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:navi_doc/Model/AmountReceived.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/Model/WorkRecord.dart';
import 'package:navi_doc/Services/api_call.dart';
import 'package:navi_doc/work_records_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAmountScreen extends StatefulWidget {
  WorkRecord? workRecord;
  AddAmountScreen({Key? key, required this.workRecord}) : super(key: key);

  @override
  _AddAmountScreenState createState() => _AddAmountScreenState(workRecord);
}

class _AddAmountScreenState extends State<AddAmountScreen> {
  WorkRecord? workRecord;
  _AddAmountScreenState(this.workRecord);

  final GlobalKey<FormState> _editWorkRecordKey = GlobalKey<FormState>();
  String? receivedValue;
  TextEditingController dateinput = TextEditingController();
  String? _hospitalName, _date, _patient, _surgeryDetail;
  int _amount=0;
  String? _dueDate;
  late AmountReceived amountReceived;
  late List<AmountReceived> AmountReceivedDetails;

  Widget amountReceivable(){
try {
  for (AmountReceived amountReceived in workRecord!.AmountReceivedDetails) {
    if (amountReceived.Amount_Received != "") {
      _amount = _amount - int.parse(amountReceived.Amount_Received);
    }
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
        initialValue: _amount.toString(),
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Receipt'),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          receivedValue = text;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Amount Charged is Required';
          }
          return null;
        },
      ),
    );
  }

  Widget onDateReceived(){
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
        controller: dateinput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
            labelText: "Received on Date"
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1960),
              lastDate: DateTime(2030)
          );
          if(pickedDate != null ){
            print(pickedDate);
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            print(formattedDate);
            setState(() {
              dateinput.text = formattedDate;
            });
          }else{
            print("Date is not selected");
          }
        },
      ),
    );
  }

  Widget submitAmount(){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
        primary: Colors.green[900],
      ), onPressed: () async {
        if (_editWorkRecordKey.currentState!.validate()){
          final prefs = await SharedPreferences.getInstance();

          UserLogin userLogin = userLoginFromJson(prefs.getString("UserLogin")!);
          amountReceived = AmountReceived(Id: 0, WorkrecordId: workRecord!.amountReceived!.WorkrecordId, Amount_Received: receivedValue.toString(), OnDate: dateinput.text, CreatedBy: "", CreatedOn: "", UpdatedBy: "", UpdatedOn: "");
          AmountReceivedDetails = [];
          workRecord!.amountReceived = amountReceived;
          workRecord!.AdminId = workRecord!.UserId;
   try {
       var updatedWorkRecord = await updateWorkRecordData(
           workRecord!, userLogin.Token);
       if (updatedWorkRecord!.success == true) {
         Fluttertoast.showToast(
             msg: "Work Record Updated Successfully",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.BOTTOM,
             timeInSecForIosWeb: 1,
             textColor: Colors.white,
             fontSize: 16.0
         );
       } else {
         Fluttertoast.showToast(
             msg: updatedWorkRecord.error,
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
          _editWorkRecordKey.currentState!.reset();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WorkRecords()));
        }
      },
        child: const Text(
            'Submit'
        ),
      ),
    );
  }

  Widget _buildHospitalName(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Hospital: "+_hospitalName!, style: const TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold
      ),
      ),
    );
  }

  Widget _buildSurgeryDate(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Surgery Date: "+_date!, style: const TextStyle(
          color: Colors.black, fontSize: 18,
      ),
      ),
    );
  }

  Widget _buildPatientName(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Patient Name: "+_patient!, style: const TextStyle(
          color: Colors.black, fontSize: 18,
      ),
      ),
    );
  }

  Widget _buildSurgeryDetail(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Details: "+_surgeryDetail!, style: const TextStyle(
        color: Colors.black, fontSize: 18,
      ),
      ),
    );
  }

  Widget _buildAmount(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Total Amount Payable: \u{20B9}"+_amount.toString(), style: const TextStyle(
          color: Colors.black, fontSize: 18,
      ),
      ),
    );
  }

  Widget _buildOutstandingDays(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Due On: "+_dueDate!, style: const TextStyle(
          color: Colors.black, fontSize: 18,
      ),
      ),
    );
  }

  Widget _buildNotes(){
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text("Note: If applicable, change Date and Amount.", style: TextStyle(
        color: Colors.black, fontSize: 15,
      ),
      ),
    );
  }

  @override
  void initState() {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    dateinput.text = formattedDate;
    super.initState();
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
              child: const Text("\t\t\t\t\t\t\t\t\tAmount Received", style: TextStyle(
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

    if (workRecord != null){
      _hospitalName = workRecord!.HospitalName;
      _date = workRecord!.SurgeryDate;
      _patient = workRecord!.PatientName;
      _amount = int.parse(workRecord!.AmountCharged);
      //_outstanding = workRecord!.OutstandingDays;
      _surgeryDetail = workRecord!.SurgeryDetail;
      _dueDate = workRecord!.DueDate;
    }

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
                key: _editWorkRecordKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 50,),
                    _buildHospitalName(),
                    const SizedBox(height: 10,),
                    _buildSurgeryDate(),
                    _buildPatientName(),
                    _buildAmount(),
                    _buildOutstandingDays(),
                    _buildSurgeryDetail(),
                    const SizedBox(height: 50,),
                    amountReceivable(),
                    const SizedBox(height: 8,),
                    onDateReceived(),
                    const SizedBox(height: 10,),
                    _buildNotes(),
                    const SizedBox(height: 50,),
                    submitAmount(),
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
