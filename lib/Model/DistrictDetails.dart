
class DistrictDetails{
  late int DistrictId, AdminId, StateId;
  late String DistrictName, DistrictDescription, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn;
  late bool DistrictStatus;


  DistrictDetails(this.StateId,this.DistrictId, this.DistrictName);

  factory DistrictDetails.fromJson(dynamic parsedJson) {
    return DistrictDetails(
      parsedJson['StateId'] ,
      parsedJson['DistrictId'] ,
      parsedJson['DistrictName'],
    );
  }
}