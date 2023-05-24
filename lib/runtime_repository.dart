import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:marlowe_run/cache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Repository which manages connecting to a wallet
class RuntimeRepository {
  RuntimeRepository({Dio? dio, CacheClient? cache})
      : _cache = cache ?? CacheClient(),
        _dio = dio ?? Dio();

  final CacheClient _cache;
  final Dio _dio;

  final String MARLOWE_RT_WEBSERVER_URL = 'services.marlowe.run:13780';

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  /// returns contractURL
  Future<String> createContract(
      {required String scJSON,
      required String address,
      required Function updateLoadingMessage}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'X-Change-Address': address
      };

      final msg =
          '{"version": "v1","tags": {},"roles": null,"minUTxODeposit": 2000000,"metadata": {},"contract": $scJSON}';

      var url = Uri.http(MARLOWE_RT_WEBSERVER_URL, 'contracts');
      var response = await http.post(url, body: msg, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      dynamic res = jsonDecode(response.body);
      String contractId = res['resource']['contractId'];
      String cborHex = res['resource']['txBody']['cborHex'];
      String description = res['resource']['txBody']['description'];
      String type = res['resource']['txBody']['type'];
      String contractURL = res['links']['contract'];

      updateLoadingMessage(message: "Signing");

      //SIGNING
      Map<String, String> headers_signing = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final msg_signing =
          '{"body": {"cborHex": "$cborHex" , "description": "" ,"type": "$type"} ,"paymentExtendedKeys": [],"paymentKeys": [{"cborHex": "5820bb921c6af621b3336460e6df335d73d4d91012718240bb95dd0301fd9aa5b5e6", "description": "Payment Signing Key", "type": "PaymentSigningKeyShelley_ed25519"}]}';

      var url_signing = Uri.http('services.marlowe.run:13779', 'sign');
      var response_signing =
          await http.post(url_signing, body: msg_signing, headers: headers);

      dynamic res_sign = jsonDecode(response_signing.body);
      dynamic tx = res_sign['tx'];

      updateLoadingMessage(message: "Submitting");
      // submiting
      Map<String, String> headers_submit = {
        'Content-Type': 'application/json',
      };
      final msg_submit = jsonEncode(tx);

      dynamic response_submit =
          await _dio.put('http://services.marlowe.run:13780/$contractURL',
              data: msg_submit,
              options: Options(
                headers: {
                  Headers.contentTypeHeader:
                      'application/json', // Set the content-length.
                },
              ));

      updateLoadingMessage(message: "Almost done");

      await Future.delayed(Duration(milliseconds: 500));
//      var response_submit =
      //        await http.put(url_submit, body: msg_submit, headers: headers_submit);

      logger.i(response_submit);
      return contractURL;
    } catch (e) {
      logger.e(e);
      throw Exception('some error or the other');
    }
  }

  Future<dynamic> getContractDetails(String? contractURL) async {
    dynamic response_contractDetails = await _dio.get(
      'http://services.marlowe.run:13780/$contractURL',
    );
    dynamic resource = response_contractDetails.data['resource'];
    logger.i(resource);
    return resource;
  }
}
