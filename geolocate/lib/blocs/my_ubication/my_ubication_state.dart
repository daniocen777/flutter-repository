part of 'my_ubication_bloc.dart';

@immutable
class MyUbicationState {
  final bool following; // Si la persona quiere que se le siga
  final bool existUbication; // Si tengo la última ubicación
  final LatLng ubication;

  MyUbicationState(
      {this.following = true, this.existUbication = false, this.ubication});

  MyUbicationState copyWith(
          {bool following, bool existUbication, LatLng ubication}) =>
      new MyUbicationState(
          following: following ?? this.following,
          existUbication: existUbication ?? this.existUbication,
          ubication: ubication ?? this.ubication);
}
