enum ApiCredential {
  apiKey('41dbef11a24e94c01add05a23078ab28'),
  baseApiUrl('https://api.themoviedb.org/3'),
  baseImageapiUrl(
      'https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg');

  final String value;

  const ApiCredential(this.value);
}
