import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/blocs/home/bloc.dart';
import 'package:musicapp/src/db/app_theme.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        return SliverToBoxAdapter(
          child: (state.status == HomeStatus.selecting)
              ? Container(
                  padding: EdgeInsets.all(15.0),
                  child: CupertinoTextField(
                    controller: this._textEditingController,
                    placeholder: 'Search...',
                    onChanged: (text) {
                      bloc.add(OnSearchEvent(text));
                    },
                    style: TextStyle(
                        fontFamily: 'sans',
                        color: MyAppTheme.instance.darkEnabled
                            ? Colors.white
                            : Colors.black),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                    suffix: (state.searchText.length > 0)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: CupertinoButton(
                              padding: EdgeInsets.all(5.0),
                              borderRadius: BorderRadius.circular(30.0),
                              minSize: 25.0,
                              child: Icon(Icons.clear),
                              color: Colors.blue,
                              onPressed: () {
                                this._textEditingController.clear();
                                bloc.add(OnSearchEvent(''));
                              },
                            ),
                          )
                        : null,
                    decoration: BoxDecoration(
                      color: MyAppTheme.instance.darkEnabled
                          ? Color(0xff29434e)
                          : Color(0xffdddddd),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}
