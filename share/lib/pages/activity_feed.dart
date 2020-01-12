import 'package:flutter/material.dart';

class ActivityFeed extends StatefulWidget {
  ActivityFeed({Key key}) : super(key: key);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed');
  }
}

class ActivityFeedItem extends StatelessWidget {
  const ActivityFeedItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}
