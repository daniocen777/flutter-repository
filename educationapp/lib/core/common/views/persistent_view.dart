import 'package:educationapp/core/common/app/providers/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({super.key, this.body});

  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

// El estado debe permanecer cuando se haga tab a otra pagina
class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => true;
}
