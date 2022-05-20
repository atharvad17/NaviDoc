import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:navi_doc/Model/SummaryReports.dart';
import 'package:navi_doc/Services/api_call.dart';
import 'package:navi_doc/Services/common.dart';
import 'package:navi_doc/home_screen.dart';
import 'package:navi_doc/practice_information_screen.dart';
import 'package:navi_doc/work_records_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  List<SummaryReports> summaryReportList = []; //filterList = [];
  //List<String>hospitalFilterList = [];
  TextEditingController fromDateInput = TextEditingController();
  TextEditingController toDateInput = TextEditingController();
  late DateTime fromDate, toDate;
  String? formattedDate1, formattedDate2, hospitalNameValue;
  int index=0;

  Widget _buildFromDate(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: fromDateInput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
            labelText: "From Date"
        ),
        readOnly: true,
        validator: (value) {
          if (value == null) {
            return 'From Date is Required';
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1960),
              lastDate: DateTime.now()
          );
          if(pickedDate != null ){
            print(pickedDate);
            formattedDate1 = DateFormat('dd-MM-yyyy').format(pickedDate);

            setState(() {
              fromDateInput.text = formattedDate1!;
              fromDate = pickedDate;
            });
          }else{
            print("Date is not selected");
          }
        },
      ),
    );
  }

  Widget _buildToDate(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: toDateInput,
        decoration: const InputDecoration(labelStyle: TextStyle(color: Colors.black),
            labelText: "To Date"
        ),
        readOnly: true,
        validator: (value) {
          if (value == null) {
            return 'To Date is Required';
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1960),
              lastDate: DateTime.now()
          );
          if(pickedDate != null ){

            formattedDate2 = DateFormat('dd-MM-yyyy').format(pickedDate);

            setState(() {
              toDateInput.text = formattedDate2!;
              toDate = pickedDate;
            });
          }else{
            print("Date is not selected");
          }
        },
      ),
    );
  }

  Widget _buildDates(){
    return Container(
      height: MediaQuery.of(context).size.height *0.1,
      child: Row(
        children: [
          _buildFromDate(),
          _buildToDate(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(style: ElevatedButton.styleFrom(
      primary: Colors.indigo[900],), onPressed: () {
              getData();
            },
                child: const Text('Submit')),
          )
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: const Text(
          'Filter by Hospital', style: TextStyle(color: Colors.black),),
        value: hospitalNameValue,
        onChanged: (newValue) {
          setState(() {
            hospitalNameValue = newValue.toString();

            //filterList = summaryReportList.where((i) => i.HospitalName == hospitalNameValue).toList();
          });
        },
        items: summaryReportList.map((newValue) {
          return DropdownMenuItem(
            child: Text(newValue.HospitalName),
            value: newValue.HospitalName,
          );
        }).toList(),
      ),
    );
  }


    // Widget _buildFilter(){
    //  return Container(
    //     child: TextFormField(
    //       initialValue: hospitalNameValue,
    //       decoration: InputDecoration(labelStyle: TextStyle(color: Colors.black), labelText: 'Filter by Hospital'),
    //       onChanged: (text) {
    //         setState(() {
    //           hospitalNameValue = text;
    //           if (hospitalNameValue == ""){
    //             hospitalFilterList = summaryReportList;
    //           }
    //           else{
    //             hospitalFilterList = summaryReportList.where((i) => i.HospitalName.toLowerCase().contains(hospitalNameValue!.toLowerCase())).toList();
    //           }
    //         });
    //       },
    //     ),
    //   );
    // }

  void getData() {
    if (toDate.compareTo(fromDate) >= 0) {
      Common.buildShowDialog(context);
      summaryReportList.clear();
      Future.wait([getSummaryReportData(context, fromDateInput.text, toDateInput.text)])
          .then((v) {
        var index = 0;
        if (v.length > 0 && v[0]!.length > 0) {
          setState(() {
            summaryReportList.addAll((v[0] as List<SummaryReports>));
            // filterList.addAll(summaryReportList);
            // for(SummaryReports summaryReports in summaryReportList)
            //   {
            //     if(!hospitalFilterList.contains(summaryReports.HospitalName))
            //     hospitalFilterList.add(summaryReports.HospitalName);
            //   }

          });
        }
        else {
          Fluttertoast.showToast(
              msg: "No Data Available",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          setState(() {
            summaryReportList.clear();
          });
        }
      }).whenComplete(() {
        Common.hideDialog(context);
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "From Date cannot be greater than To Date",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {
        summaryReportList.clear();
      });
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
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.5,
              child: const Text('\t\t\t\t\t\t\t\t\t\t\t\tReports', style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.3,
              child: TextButton(
                child: const Text("Mail me \u{1F4E7}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),),
                // icon: const Icon(
                //   Icons.email,
                //   size: 28,
                //   color: Colors.white,
                // ),
                onPressed: () async{
                  if (summaryReportList.isEmpty || summaryReportList.length == 0){
                    Fluttertoast.showToast(
                        msg: "No Data Available to send to Email Address",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else{
                    var result = await getMailReportData(context, fromDateInput.text, toDateInput.text);
                    Common.buildShowDialog(context);
                    if (result!.success == true){
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
                    else{
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
                  }
                },
              ),
            ),
          ],
        )

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fromDateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(const Duration(days: 7))).toString();
    toDateInput.text = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    fromDate = DateTime.now();
    toDate = DateTime.now();
    //lastWeekDate = DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(const Duration(days: 7)));

    Common.buildShowDialog(context);
    summaryReportList.clear();
    Future.wait([getSummaryReportData(context, fromDateInput.text, toDateInput.text)])
        .then((v) {
      var index = 0;
      if (v.length > 0 && v[0]!.length > 0) {
        setState(() {
          summaryReportList.addAll((v[0] as List<SummaryReports>));
          // filterList.addAll(summaryReportList);
          // for(SummaryReports summaryReports in summaryReportList)
          //   {
          //     if(!hospitalFilterList.contains(summaryReports.HospitalName))
          //     hospitalFilterList.add(summaryReports.HospitalName);
          //   }

        });
      }
      else {
        Fluttertoast.showToast(
            msg: "No Data Available",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        setState(() {
          summaryReportList.clear();
        });
      }
    }).whenComplete(() {
      Common.hideDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
  //  final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green[900],
        // title: const Text('Reports'),
        backgroundColor: Colors.white,
        //leading: const Icon(Icons.view_headline, color: Colors.black,),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Image.asset('assets/images/navigo4.jpg', height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.width * 0.2,),
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildDates(),
          //_buildFilter(),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 15,
                  columns: const [
                    //DataColumn(label: Text('Sr No.')),
                    DataColumn(label: Text('Hospital')),
                    DataColumn(label: Text('Surgery Date')),
                    DataColumn(label: Text('Amount Billed')),
                    DataColumn(label: Text('Amount Received')),
                    DataColumn(label: Text('Patient Name')),
                    DataColumn(label: Text('Patient Age')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Surgery Procedure')),
                  ],
                  rows:
                  summaryReportList // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                    ((element) => DataRow(
                      cells: <DataCell>[
                        //DataCell(Text(element.SrNo.toString().trim())),
                        DataCell(Text(element.HospitalName.trim())), //Extracting from Map element the value
                        DataCell(Text(element.SurgeryDate.trim())),
                        DataCell(Text(element.AmountBilled.trim())), //Extracting from Map element the value
                        DataCell(Text(element.AmountReceived.toString().trim())),
                        DataCell(Text(element.PatientName.trim())), //Extracting from Map element the value
                        DataCell(Text(element.PatientAge.trim())),
                        DataCell(Text(element.SurgeryCategory.trim())), //Extracting from Map element the value
                        DataCell(Text(element.SurgeryProcedure.trim())),
                      ],
                    )),
                  )
                      .toList(),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *0.08,
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width *0.05,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width *0.35,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[900],
                  ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const PracticeInformationScreen()));
                    },
                    child: const Text('Hospitals'),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width *0.2,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width *0.35,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[900],
                  ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const WorkRecords()));
                    },
                    child: const Text('Procedures'),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width *0.05,),
              ],
            ),
          )
          // Center(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     width: MediaQuery.of(context).size.width * 0.3,
          //     child: ElevatedButton(style: ElevatedButton.styleFrom(
          //       primary: Colors.indigo[900], shape: const RoundedRectangleBorder(side: BorderSide(
          //         color: Colors.black,
          //         width: 2,
          //         style: BorderStyle.solid
          //     ), ),), onPressed: () async {
          //       if (summaryReportList.isEmpty || summaryReportList.length == 0){
          //         Fluttertoast.showToast(
          //             msg: "No Data Available to send to Email Address",
          //             toastLength: Toast.LENGTH_SHORT,
          //             gravity: ToastGravity.BOTTOM,
          //             timeInSecForIosWeb: 1,
          //             textColor: Colors.white,
          //             fontSize: 16.0
          //         );
          //       }else{
          //         var result = await getMailReportData(context, fromDateInput.text, toDateInput.text);
          //         Common.buildShowDialog(context);
          //         if (result!.success == true){
          //           Common.hideDialog(context);
          //           Fluttertoast.showToast(
          //               msg: result.error,
          //               toastLength: Toast.LENGTH_SHORT,
          //               gravity: ToastGravity.BOTTOM,
          //               timeInSecForIosWeb: 1,
          //               textColor: Colors.white,
          //               fontSize: 16.0
          //           );
          //         }
          //         else{
          //           Common.hideDialog(context);
          //           Fluttertoast.showToast(
          //               msg: result.error,
          //               toastLength: Toast.LENGTH_SHORT,
          //               gravity: ToastGravity.BOTTOM,
          //               timeInSecForIosWeb: 1,
          //               textColor: Colors.white,
          //               fontSize: 16.0
          //           );
          //         }
          //       }
          //
          //     }, child: Row(
          //       children: const [
          //         Text('Mail Me  '),
          //         Icon(Icons.mail),
          //       ],
          //     ),

                // Future.wait([getMailReportData(context, fromDateInput.text, toDateInput.text)])
                //     .then((v) {
                //   var index = 0;
                //   if (v.length > 0 && v[0]!.length > 0) {
                //     setState(() {
                //       summaryReportList.addAll((v[0] as List<SummaryReports>));
                //       Fluttertoast.showToast(
                //           msg: "Work details sent to given email address",
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.BOTTOM,
                //           timeInSecForIosWeb: 1,
                //           textColor: Colors.white,
                //           fontSize: 16.0
                //       );
                //       // filterList.addAll(summaryReportList);
                //       // for(SummaryReports summaryReports in summaryReportList)
                //       //   {
                //       //     if(!hospitalFilterList.contains(summaryReports.HospitalName))
                //       //     hospitalFilterList.add(summaryReports.HospitalName);
                //       //   }
                //
                //     });
                //   }
                //   else {
                //     Fluttertoast.showToast(
                //         msg: "Couldn't Mail Work details",
                //         toastLength: Toast.LENGTH_SHORT,
                //         gravity: ToastGravity.BOTTOM,
                //         timeInSecForIosWeb: 1,
                //         textColor: Colors.white,
                //         fontSize: 16.0
                //     );
                //     setState(() {
                //       summaryReportList.clear();
                //     });
                //   }
                // }).whenComplete(() {
                //   Common.hideDialog(context);
                // });

          //     ),
          //   ),
          // ),
        ],
      )
    );
  }
}
