
class SpecialityDetails{
  late int Id, DegreeId, AdminId;
  late String Speciality, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn;
  late bool Active;

  SpecialityDetails(this.DegreeId, this.Speciality);

  factory SpecialityDetails.fromJson(dynamic parsedJson) {
    return SpecialityDetails(
      parsedJson['DistrictId'] ,
      parsedJson['Speciality'],
    );
  }
}