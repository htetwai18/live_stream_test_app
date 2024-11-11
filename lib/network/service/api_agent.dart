import 'package:dio/dio.dart';
import 'package:live_stream_test_app/network/request/aquire_request.dart';
import 'package:live_stream_test_app/network/request/start_request.dart';
import 'package:live_stream_test_app/network/request/stop_request.dart';
import 'package:live_stream_test_app/network/response/acquire_response.dart';
import 'package:live_stream_test_app/network/response/query_response.dart';
import 'package:live_stream_test_app/network/response/start_response.dart';
import 'package:live_stream_test_app/network/response/stop_response.dart';
import 'package:live_stream_test_app/network/service/api_constants.dart';
import 'package:live_stream_test_app/network/service/api_service.dart';

class ApiAgent {
  ApiAgent._internal();
  static final ApiAgent _singleton = ApiAgent._internal();
  factory ApiAgent() => _singleton;

  Future<AcquireResponse> acquire(String appId, AcquireRequest request) async {
    var data = request.toJson();
    var dio = DioUtil.getDio();
    try {
      final response = await dio.post(ApiConstants.acquire(appId), data: data);
      if (response.statusCode == 200) {
        return AcquireResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<StartResponse> start(
      String appId, String resourceId, StartRequest request) async {
    var data = request.toJson();
    var dio = DioUtil.getDio();
    try {
      final response =
          await dio.post(ApiConstants.start(appId, resourceId), data: data);
      if (response.statusCode == 200) {
        return StartResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<QueryResponse> query(
      String appId, String resourceId, String sid) async {
    var dio = DioUtil.getDio();
    try {
      final response =
          await dio.get(ApiConstants.query(appId, resourceId, sid));
      if (response.statusCode == 200) {
        return QueryResponse.fromJson(response.data);
      }
      throw Exception('Failed to load response');
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<StopResponse> stop(
      String appId, String resourceId, String sid, StopRequest request) async {
    var data = request.toJson();
    var dio = DioUtil.getDio();
    try {
      final response =
          await dio.post(ApiConstants.stop(appId, resourceId, sid), data: data);
      if (response.statusCode == 200) {
        return StopResponse.fromJson(response.data);
      }
      throw Exception(response.statusCode);
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
