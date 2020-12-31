import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocate/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:geolocate/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline/polyline.dart' as Poly;

import 'package:geolocate/search/search_destiny.dart';

import 'package:geolocate/models/search_result.dart';
import 'package:geolocate/blocs/map/map_bloc.dart';
import 'package:geolocate/blocs/my_ubication/my_ubication_bloc.dart';
import 'package:geolocate/blocs/seach/search_bloc.dart';
import 'package:geolocate/services/traffic_service.dart';

part 'location_button.dart';
part 'my_route_button.dart';
part 'follow_button.dart';
part 'search_bar.dart';
part 'manual_marker.dart';
