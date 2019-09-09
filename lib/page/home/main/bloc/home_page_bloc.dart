import 'package:Sarh/data/session.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final Session session;

  HomePageBloc(this.session);

  @override
  HomePageState get initialState => HomePageIdle();
  @override
  void onTransition(Transition<HomePageEvent, HomePageState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is NavigateToProfile) {
      if (session.isCompany) {
        yield NavigateToCompanyProfile();
      } else {
        yield NavigateToUserProfile();
      }
    }
  }
}
