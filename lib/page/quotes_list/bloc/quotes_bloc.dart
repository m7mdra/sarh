import 'package:Sarh/data/quote/quotation_repository.dart';

import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuoteState> {
  final QuotationRepository _quotationRepository;

  QuotesBloc(this._quotationRepository);

  @override
  QuoteState get initialState => Loading();

  @override
  Stream<QuoteState> mapEventToState(QuotesEvent event) async* {
    if (event is LoadQuotes) {
      yield Loading();
      try {
        var response = await _quotationRepository.getQuotations();
        if (response.success) {
          var list = response.data;
          if (list.isNotEmpty) {
            yield Success();
          } else {
            yield Empty();
          }
        } else {
          yield Error();
        }
      } on SessionExpiredException {
        yield SessionExpired();
      } on UnableToConnectException {
        yield NetworkError();
      } on TimeoutException {
        yield Timeout();
      } catch (error) {
        yield Error();
        print(error);
      }
    }
  }
}
