import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PhoneValidationApi
{
  static final _apiKey = dotenv.env['PHONE_API']!;
  static const _baseUrl = 'https://phonevalidation.abstractapi.com/v1/';

  bool? isValidPhoneNumber;

  Future<bool> validatePhone(String phone) async
  {
    final request = Uri.parse(_baseUrl+ "?api_key=" + _apiKey + "&phone=" + phone);
    final response = await http.get(request);
    print(json.decode(response.body));
    Map<String, dynamic>? data = jsonDecode(response.body);
    return data!['valid'];
  }
}