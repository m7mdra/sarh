import 'package:Sarh/data/session.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final Session _session;

  CompanyProfileBloc(this._session);

  @override
  CompanyProfileState get initialState =>
      ProfileLoaded(_session.user, _session.company);

  @override
  Stream<CompanyProfileState> mapEventToState(
      CompanyProfileEvent event) async* {
    yield ProfileLoaded(_session.user, _session.company);
  }
}
