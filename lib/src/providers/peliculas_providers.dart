import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '0b22e852e192f50493ac3ecbbb944328';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _languaje});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.http(
        _url, '3/movie/popular', {'api_key': _apikey, 'language': _languaje});

    return await _procesarRespuesta(url);
  }
}
