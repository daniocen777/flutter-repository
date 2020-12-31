import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocate/models/search_response.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:geolocate/models/search_result.dart';
import 'package:geolocate/services/traffic_service.dart';

class SearchDestiny extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  final LatLng proximity;
  final List<SearchResult> historial;

  // Servicio
  final TrafficService _trafficService;

  SearchDestiny(this.proximity, this.historial)
      : this.searchFieldLabel = 'Write',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => this.query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this.close(context, SearchResult(cancel: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Put manually ubication'),
            onTap: () {
              print('Sugerencias');
              this.close(context, SearchResult(cancel: false, manual: true));
            },
          ),
          // historial
          ...this
              .historial
              .map((result) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(result.nameDestiny),
                    subtitle: result.description != null
                        ? Text(result.description)
                        : Text('Sin descripción'),
                    onTap: () {
                      this.close(context, result);
                    },
                  ))
              .toList()
        ],
      );
    }

    return this._buildResultsAndSuggestions();
  }

  Widget _buildResultsAndSuggestions() {
    if (this.query.length == 0) return Container();

    // this.query.trim(), proximity
    this
        ._trafficService
        .getSugerenciasPorQuery(this.query.trim(), this.proximity);

    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CupertinoActivityIndicator());
        }
        // Lugares
        final List<Feature> features = snapshot.data.features;
        if (features.length == 0)
          return ListTile(
            title: Text('No results with $query'),
          );

        return ListView.separated(
          itemCount: features.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            final feature = features[index];
            return ListTile(
                leading: Icon(Icons.place),
                title: Text(feature.textEs),
                subtitle: Text(feature.placeNameEs),
                onTap: () {
                  this.close(
                      context,
                      SearchResult(
                          cancel: false,
                          manual: false,
                          position:
                              LatLng(feature.center[1], feature.center[0]),
                          nameDestiny: feature.placeNameEs));
                });
          },
        );
      },
    );
  }
}
