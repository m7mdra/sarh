/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/dependency_provider.dart';
import 'package:Sarh/widget/ui_state.dart';
import 'bloc/bloc.dart';
import 'package:Sarh/widget/back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteListPage extends StatefulWidget {
  @override
  _QuoteListPageState createState() => _QuoteListPageState();
}

class _QuoteListPageState extends State<QuoteListPage> {
  QuotesBloc _quotesBloc;

  @override
  void initState() {
    super.initState();
    _quotesBloc = QuotesBloc(DependencyProvider.provide());
    _loadQuotes();
  }

  void _loadQuotes() {
    _quotesBloc.dispatch(LoadQuotes());
  }

  @override
  void dispose() {
    super.dispose();
    _quotesBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonNoLabel(Colors.white),
        centerTitle: true,
        title: Text('Quotations'),
      ),
      body: BlocBuilder(
        bloc: _quotesBloc,
        builder: (BuildContext context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is NetworkError) {
            return Center(
              child: NetworkErrorWidget(
                onRetry: _loadQuotes,
              ),
            );
          }
          if (state is Error) {
            return Center(
              child: GeneralErrorWidget(
                onRetry: _loadQuotes,
              ),
            );
          }
          if (state is Timeout) {
            return Center(
              child: TimeoutWidget(
                onRetry: _loadQuotes,
              ),
            );
          }
          if (state is Empty) {
            return Center(
              child: EmptyWidget(),
            );
          }
          if (state is Success) {
            return Icon(Icons.check);
          }
        },
      ),
    );
  }
}
