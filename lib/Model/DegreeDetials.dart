
class DegreeDetails{
  late int Id, AdminId;
  late String Name, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn;
  late bool Active;

  DegreeDetails(this.Id, this.Name);

  factory DegreeDetails.fromJson(dynamic parsedJson) {
    return DegreeDetails(

      parsedJson['Id'] ,
      parsedJson['Name'],
    );
  }
}