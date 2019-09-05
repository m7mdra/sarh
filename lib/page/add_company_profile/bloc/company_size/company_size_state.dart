import 'package:Sarh/data/model/company_size.dart';

class AddCompanyInfoState{
}
class CompanySizeLoaded extends AddCompanyInfoState{
  final List<CompanySize> sizes;

  CompanySizeLoaded(this.sizes);
}
class CompanySizeFailed extends AddCompanyInfoState{}
