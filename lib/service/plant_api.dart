part of './service.dart';

class Api {
  static List<String> keys = [
    "sk-NDmD65684e3752f783203",
    "sk-TtRm6567394dcee4a3190",
    "sk-Tyvx657085b5ed0713364"
  ];
  static List<String> headpoints = ["", "&cycle=perennial", "&cycle=annual"];
  static int keyIndex = 0;

  static Future<List<PlantClass>> _get(
      {required int page,
      int pageSize = 20,
      required int index,
      bool search = false,
      String searchKey = ""}) async {
    //open local file
    final shared = Shared();
    await shared.open();

    // Check the cache first
    final String cacheKey =
        "plantApiCache${index}_${page}_${pageSize}_$searchKey";
    final String? cachedData = shared.file.getString(cacheKey);

    if (cachedData != null) {
      final List<dynamic> results = json.decode(cachedData)['data'];
      return results
          .map(
            (json) => PlantClass.fromJson(json),
          )
          .toList();
    }

    // If not cached, fetch data from the API
    try {
      Uri api;
      if (!search) {
        api = Uri.parse(
            "https://perenual.com/api/species-list?key=${keys[keyIndex]}&page=$page&pageSize=$pageSize${headpoints[index]}");
      } else {
        api = Uri.parse(
            "https://perenual.com/api/species-list?key=${keys[keyIndex]}&page=$page&pageSize=$pageSize${headpoints[index]}&q=$searchKey");
      }

      var request = http.Request('GET', api);
      final http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        debugPrint("API GET request succes");
        final String responseBody = await response.stream.bytesToString();
        final Map<String, dynamic>? body = json.decode(responseBody);

        if (body == null || body['data'] == null) {
          debugPrint('API response body is null or does not contain data.');
          throw Exception('GET Retrieve Nothing');
        }
        // Cache the data
        shared.file.setString(cacheKey, json.encode(body));

        final List<dynamic> results = body['data'];
        return results
            .map(
              (json) => PlantClass.fromJson(json),
            )
            .toList();
      } else if (response.statusCode == 429) {
        keyIndex++;
        if (keyIndex < keys.length) {
          return _get(page: page, index: index);
        }
        debugPrint('Response body: ${await response.stream.bytesToString()}');
        throw Exception('Failed to load plants');
      } else {
        debugPrint(
            'API request failed with status code ${response.statusCode}');
        debugPrint('Response body: ${await response.stream.bytesToString()}');
        throw Exception('Failed to load plants');
      }
    } catch (e) {
      debugPrint('Error during API request: $e');
      throw Exception('Failed to load plants');
    }
  }

  static Future<List<PlantClass>> futureData(
      {required int page, required int index}) async {
    return await _get(page: page, index: index);
  }

  static Future<List<PlantClass>> searchdata(
      {required int page,
      required int index,
      required String searchKey}) async {
    return await _get(
        page: page, index: index, search: true, searchKey: searchKey);
  }
}
