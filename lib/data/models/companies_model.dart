class CompanyModel{
  final String name;
  CompanyModel({required this.name});

  factory CompanyModel.data(Map<String,dynamic> response){
    return CompanyModel(name: response['name']);
  }

}