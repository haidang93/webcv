import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException catch (_) {
    return false;
  }
}

class Network {
  Network() {
    // client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
  // Network._private();
  // static final Network instance = Network._private();
  HttpClient client = HttpClient();
  String endpoint = '';
  Function defaultDecoder;
  Map<String, String> header = {};
  Map<String, String> contentType;

  // Future<bool> init(String password) async {
  //   final cert = Certificate.instance;
  //   SecurityContext context = SecurityContext();
  //   try {
  //     context.setTrustedCertificatesBytes(cert.pfx.buffer.asUint8List(),
  //         password: password);
  //   } catch (e) {
  //     return false;
  //   }
  //   context.useCertificateChainBytes(cert.crt.buffer.asUint8List());
  //   context.usePrivateKeyBytes(cert.key.buffer.asUint8List());
  //   client = HttpClient(context: context);
  //   client.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) => true;
  //   return true;
  // }

  Future<Response<T>> post<T>(String api, Map body, {Map<String, dynamic> header, Function decoder}) async {
    HttpClientRequest request;
    HttpClientResponse response;
    String url = (api.contains('http') ? '' : endpoint) + api;
    if (await hasInternet()) {
      Uri uri = Uri.parse(url);
      request = await client.postUrl(uri).onError((error, stackTrace) => null).timeout(
            Duration(seconds: 15),
            onTimeout: () => null,
          );
      if (request != null) {
        if (header != null)
          header.forEach((key, value) {
            request.headers.add(key, value);
          });
        this.header.forEach((key, value) {
          request.headers.add(key, value);
        });
        if (contentType == null) {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
        } else {
          contentType.forEach((key, value) {
            request.headers.add(key, value);
          });
        }
        request.write(jsonEncode(body));
        try {
          response = await request.close().timeout(Duration(seconds: 15));
        } on SocketException {
          return Response(null, 333, 'Something went wrong!');
        } on TimeoutException {
          return Response(null, 333, 'Connection time out!');
        }

        // if (response.statusCode >= 200 && response.statusCode < 300) {
        dynamic res;
        try {
          res = jsonDecode(await response.transform(utf8.decoder).join());
        } on FormatException catch (e) {
          log(e.message);
          return Response(null, response.statusCode, 'Wrong response format');
        }
        // if (res['code'] == 401) wrongToken();
        return Response(() {
          if (decoder != null) {
            return decoder(res);
          }
          return res;
        }(), res['code'] ?? response.statusCode, res['message'] ?? response.reasonPhrase);
        // } else {
        //   return Response(null, response.statusCode, response.reasonPhrase);
        // }
      }
      return Response(null, 333, 'Failed host lookup!\n$api');
    } else {
      return Response(null, 000, 'No internet');
    }
  }

  Future<Response> put(String api, Map body, {Map<String, dynamic> header, Function decoder}) async {
    HttpClientRequest request;
    HttpClientResponse response;
    String url = (api.contains('http') ? '' : endpoint) + api;
    if (await hasInternet()) {
      Uri uri = Uri.parse(url);
      request = await client.putUrl(uri).onError((error, stackTrace) => null).timeout(
            Duration(seconds: 15),
            onTimeout: () => null,
          );
      if (request != null) {
        if (header != null)
          header.forEach((key, value) {
            request.headers.add(key, value);
          });
        this.header.forEach((key, value) {
          request.headers.add(key, value);
        });
        if (contentType == null) {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
        } else {
          contentType.forEach((key, value) {
            request.headers.add(key, value);
          });
        }
        request.write(jsonEncode(body));
        try {
          response = await request.close().timeout(Duration(seconds: 15));
        } on SocketException {
          return Response(null, 333, 'Something went wrong!');
        } on TimeoutException {
          return Response(null, 333, 'Connection time out!');
        }

        // if (response.statusCode >= 200 && response.statusCode < 300) {
        dynamic res;
        try {
          res = jsonDecode(await response.transform(utf8.decoder).join());
        } on FormatException catch (e) {
          log(e.message);
          return Response(null, 333, 'Wrong response format');
        }
        // if (res['code'] == 401) wrongToken();
        return Response(() {
          if (decoder != null) {
            return decoder(res);
          }
          return res;
        }(), res['code'] ?? response.statusCode, res['message'] ?? response.reasonPhrase);
        // } else {
        //   return Response(null, response.statusCode, response.reasonPhrase);
        // }
      }
      return Response(null, 333, 'Failed host lookup!\n$api');
    } else {
      return Response(null, 000, 'No internet');
    }
  }

  Future<Response> request(
    String api,
    String path,
    Map body, {
    Map<String, dynamic> header,
    Function decoder,
    int timeOut,
  }) async {
    HttpClientRequest request;
    HttpClientResponse response;
    String url = (api.contains('http') ? '' : endpoint) + api;
    if (await hasInternet()) {
      Uri uri = Uri.parse(url);
      request = await client.patchUrl(uri).onError((error, stackTrace) => null).timeout(
            Duration(seconds: 15),
            onTimeout: () => null,
          );
      if (request != null) {
        if (header != null)
          header.forEach((key, value) {
            request.headers.add(key, value);
          });
        this.header.forEach((key, value) {
          request.headers.add(key, value);
        });
        if (contentType == null) {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
        } else {
          contentType.forEach((key, value) {
            request.headers.add(key, value);
          });
        }
        request.write(jsonEncode(body));
        try {
          response = await request.close().timeout(Duration(seconds: 15));
        } on SocketException {
          return Response(null, 333, 'Something went wrong!');
        } on TimeoutException {
          return Response(null, 333, 'Connection time out!');
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          dynamic res;
          try {
            res = jsonDecode(await response.transform(utf8.decoder).join());
          } on FormatException catch (e) {
            log(e.message);
            return Response(null, 333, 'Wrong response format');
          }
          // if (res['code'] == 401) wrongToken();
          return Response(() {
            if (decoder != null) {
              return decoder(res);
            }
            return res;
          }(), res['code'] ?? response.statusCode, res['message'] ?? response.reasonPhrase);
        } else {
          return Response(null, response.statusCode, response.reasonPhrase);
        }
      }
      return Response(null, 333, 'Failed host lookup!\n$api');
    } else {
      return Response(null, 000, 'No internet');
    }
  }

  Future<Response<T>> get<T>(String api, {Map<String, dynamic> header, Function decoder}) async {
    HttpClientRequest request;
    HttpClientResponse response;
    String url = (api.contains('http') ? '' : endpoint) + api;
    if (await hasInternet()) {
      Uri uri = Uri.parse(url);
      request = await client.getUrl(uri).timeout(
            Duration(seconds: 5),
            onTimeout: () => null,
          );
      if (request != null) {
        if (header != null)
          header.forEach((key, value) {
            request.headers.add(key, value);
          });
        this.header.forEach((key, value) {
          request.headers.add(key, value);
        });
        if (contentType == null) {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
        } else {
          contentType.forEach((key, value) {
            request.headers.add(key, value);
          });
        }
        try {
          response = await request.close().timeout(Duration(seconds: 10));
        } on SocketException {
          return Response(null, 333, 'Something went wrong!');
        } on TimeoutException {
          return Response(null, 333, 'Connection time out!');
        }

        // if (response.statusCode >= 200 && response.statusCode < 300) {
        dynamic res;
        final data = await response.transform(utf8.decoder).join();
        try {
          res = jsonDecode(data);
        } on FormatException {
          res = data;
        } // if (res['code'] == 401) wrongToken();
        return Response(() {
          if (decoder != null) {
            return decoder(res);
          }
          if (defaultDecoder != null) {
            return defaultDecoder(res);
          }
          return res;
        }(), res['code'] ?? response.statusCode, res['message'] ?? response.reasonPhrase);
        // } else {
        //   return Response(null, response.statusCode, response.reasonPhrase);
        // }
      }
      return Response(null, 333, 'Failed host lookup!\n$api');
    } else {
      return Response(null, 000, 'No internet');
    }
  }

  Future<Response> delete(String api, {Map<String, dynamic> header, Function decoder}) async {
    HttpClientRequest request;
    HttpClientResponse response;
    String url = (api.contains('http') ? '' : endpoint) + api;
    if (await hasInternet()) {
      Uri uri = Uri.parse(url);
      request = await client.deleteUrl(uri).onError((error, stackTrace) => null).timeout(
            Duration(seconds: 5),
            onTimeout: () => null,
          );
      if (request != null) {
        if (header != null)
          header.forEach((key, value) {
            request.headers.add(key, value);
          });
        this.header.forEach((key, value) {
          request.headers.add(key, value);
        });
        if (contentType == null) {
          request.headers.contentType = ContentType('application', 'json', charset: 'utf-8');
        } else {
          contentType.forEach((key, value) {
            request.headers.add(key, value);
          });
        }
        try {
          response = await request.close().timeout(Duration(seconds: 10));
        } on SocketException {
          return Response(null, 333, 'Something went wrong!');
        } on TimeoutException {
          return Response(null, 333, 'Connection time out!');
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          dynamic res;
          final data = await response.transform(utf8.decoder).join();
          try {
            res = jsonDecode(data);
          } on FormatException {
            res = data;
          } // if (res['code'] == 401) wrongToken();
          return Response(() {
            if (decoder != null) {
              return decoder(res);
            }
            if (defaultDecoder != null) {
              return defaultDecoder(res);
            }
            return res;
          }(), response.statusCode, response.reasonPhrase);
        } else {
          return Response(null, response.statusCode, response.reasonPhrase);
        }
      }
      return Response(null, 333, 'Failed host lookup!\n$api');
    } else {
      return Response(null, 000, 'No internet');
    }
  }

  void wrongToken() async {}
}

class Response<T> {
  int statusCode;
  String statusText;
  T body;
  Map<String, dynamic> get data => body ?? {};
  //Map<String, dynamic> get data => body['data'] ?? {};

  Response(this.body, this.statusCode, this.statusText);
}
