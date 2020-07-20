import 'package:flutter/material.dart';
import 'package:noticiasapp/src/services/new_service.dart';
import 'package:noticiasapp/src/widgets/news_widget.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key key}) : super(key: key);

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

/* AutomaticKeepAliveClientMixin => Mantener el estado cuado vaya a otra página */
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewService>(context);
    return Scaffold(
        body: (newService.headlines.length == 0)
            ? Center(child: CircularProgressIndicator())
            : NewsWidget(
                news: newService.headlines,
              ));
  }

  @override
  bool get wantKeepAlive => true;

  
}
