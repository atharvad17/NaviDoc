
class CityDetails{
  late int Id, DistrictId, StateId, AdminId;
  late String Name, Description, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn;
  late bool Status;

  CityDetails(this.DistrictId, this.StateId, this.Name);

  factory CityDetails.fromJson(dynamic parsedJson) {
    return CityDetails(
      parsedJson['DistrictId'] ,
      parsedJson['StateId'] ,
      parsedJson['Name'],
    );
  }
}