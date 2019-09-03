import 'package:Sarh/data/company/company_repository.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size_event.dart';
import 'package:Sarh/page/add_company_profile/bloc/company_size_state.dart';
import 'package:bloc/bloc.dart';

class CompanySizeBloc
    extends Bloc<AddCompanyInfoEvent, AddCompanyInfoState> {
  final CompanyRepository _companyRepository;

  CompanySizeBloc(this._companyRepository);

  @override
  AddCompanyInfoState get initialState => AddCompanyInfoState();
@override
  void onTransition(Transition<AddCompanyInfoEvent, AddCompanyInfoState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
  @override
  Stream<AddCompanyInfoState> mapEventToState(
      AddCompanyInfoEvent event) async* {
    if(event is LoadCompanySize){
      try{
        var response=await _companyRepository.getCompanySizeRanges();
        yield CompanySizeLoaded(response.sizes);
      }catch(error){
        yield CompanySizeFailed();
      }
    }
  }
}
