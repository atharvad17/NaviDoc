
class StateDetails{
  late int StateId, AdminId;
  late String StateName, StateDescription, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn;
  late bool Status;

  StateDetails(
      this.StateId,
      this.StateName,

      );



  factory StateDetails.fromJson(dynamic parsedJson) {
    return StateDetails(

       parsedJson['StateId'] ,
       parsedJson['StateName'],
    );
  }
}