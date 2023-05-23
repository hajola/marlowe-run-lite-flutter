import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:marlowe_run/cache.dart';

/// Repository which manages connecting to a wallet
class AuthenticationRepository {
  AuthenticationRepository({Dio? dio, CacheClient? cache})
      : _cache = cache ?? CacheClient(),
        _dio = dio ?? Dio();

  final CacheClient _cache;
  final Dio _dio;

  final String url = '';
  /**
   * 
   * 
   * 
Request, which will be JSON:
data SignRequest =
  Sign
  { reqTxBody :: C.TxBody C.BabbageEra
  , reqPaymentKeys :: [C.SigningKey C.PaymentKey]
  , reqPaymentExtendedKeys :: [C.SigningKey C.PaymentExtendedKey]
  }
Response, which will also be JSON:
data SignResponse =
  Tx
  { resTxId :: TxId
  , resTx :: C.Tx C.BabbageEra
  }
   */

  Future<SignResponse?>? sign(
      {required String signingKey, required String paymentKey}) async {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

    SignResponse signResponse;

    try {
      Response response =
          await _dio.post('/test', data: {'id': 12, 'name': 'dio'});

      signResponse =
          SignResponse(response.data['resTxId'], response.data['resTx']);
      return signResponse;
    } on DioError catch (e) {
      if (e.response != null) {
        logger.e(e.response?.data);
        logger.e(e.response?.headers);
        logger.e(e.response?.requestOptions);
      } else {
        logger.e(e.requestOptions);
        logger.e(e.message);
      }
    } catch (e) {
      logger.e(e);
    }
    throw WalletConnectionException('Error signing wallet');
  }
}

class WalletConnectionException implements Exception {
  String error;
  WalletConnectionException(this.error);
}

class SignResponse {
  final String TransactionID;
  final String Transaction;
  SignResponse(this.TransactionID, this.Transaction);
}
