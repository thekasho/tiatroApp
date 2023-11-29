import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tiatrotv/core/class/statusrequest.dart';
import 'package:tiatrotv/core/functions/check_network.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    try {
      if (await checkNetwork()) {
        var response = await http.post(Uri.parse(linkurl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      debugPrint("Crud Error: $e");
      return const Left(StatusRequest.serveException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl) async {
    try {
      if (await checkNetwork()) {
        var response = await http.post(Uri.parse(linkurl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      debugPrint("Crud Error: $e");
      return const Left(StatusRequest.serveException);
    }
  }

  Future<Either<StatusRequest, List>> getListData(String linkurl) async {
    try {
      if (await checkNetwork()) {
        
        var response = await http.post(Uri.parse(linkurl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          List responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      debugPrint("Crud Error: $e");
      return const Left(StatusRequest.serveException);
    }
  }
}
