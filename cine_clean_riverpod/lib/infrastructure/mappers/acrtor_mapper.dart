import '../../domain/entities/actor.dart';
import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: (cast.profilePath != null)
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://www.circumcisionpro.co.uk/wp-content/uploads/2021/05/avatar-profile-picture.jpg',
        character: cast.character,
      );
}
