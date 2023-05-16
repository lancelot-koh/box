

import 'package:box/data/api/api_client.dart';
import 'package:box/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    //
  }
}