import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/models/Product.dart';
import 'package:sariapp/models/ProductCategory.dart';
import 'package:sariapp/models/ProductSubcategory.dart';
import 'package:sariapp/services/MerchantService.dart';
import 'package:sariapp/services/ProductCategoryService.dart';
import 'package:sariapp/services/ProductService.dart';
import 'package:sariapp/services/ProductSubcategoryService.dart';
import 'package:sariapp/utils/Constants.dart';
import 'package:sariapp/utils/Helper.dart';

class ApiService {
  static void getMerchantList(context) async {
    Uri sariUrl = _getParsedSariEndpoint(
        "$kLocalHost/$kApiVersion/$kMerchantList?maxResult=100&page=0");

    // start loading
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    http.Response sariResponse =
        await http.get(sariUrl, headers: _apiHeaders(false));

    _handleApiResponse(context, sariResponse.statusCode, () {
      var decodedSearch = jsonDecode(sariResponse.body)['body'];
      var searchResultCount = decodedSearch['totalPages'];
      var searchContent = decodedSearch['content'];
      List<Merchant> merchants = [];

      if (searchResultCount > 0) {
        for (var searchItem in searchContent) {
          merchants.add(Merchant.fromJson(searchItem));
        }

        MerchantService.setProviderMerchantList(context, merchants);
      } else {
        // no search result found
        Helper.showInfoToast(context, "No stores yet.");
      }
    });
  }

  static void getMerchantById(context, id) async {
    Uri sariUrl = _getParsedSariEndpoint(
        "$kLocalHost/$kApiVersion/$kMerchantSearchById$id");

    // start loading
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    http.Response sariResponse =
        await http.get(sariUrl, headers: _apiHeaders(false));

    _handleApiResponse(context, sariResponse.statusCode, () {
      var decodedSearch = jsonDecode(sariResponse.body)['body'];

      if (decodedSearch != null) {
        MerchantService.setProviderActiveMerchant(
            context, Merchant.fromJson(decodedSearch));
      } else {
        // no search result found
        Helper.showInfoToast(context, "No stores yet.");
      }
    });
  }

  // static void search(context, String query) async {
  //   Uri sariUrl = _getParsedSariEndpoint(
  //       "$kLocalHost/$kApiVersion/$kSearchRoute?maxResult=100&page=0&storeName=$query");
  //
  //   // start loading
  //   EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
  //
  //   http.Response sariResponse =
  //       await http.get(sariUrl, headers: _apiHeaders(false));
  //
  //   _handleApiResponse(context, sariResponse.statusCode, () {
  //     var decodedSearch = jsonDecode(sariResponse.body);
  //     var searchResultCount = decodedSearch['size'];
  //     var searchContent = decodedSearch['content'];
  //     List<Merchant> merchants = [];
  //
  //     if (searchResultCount > 0) {
  //       for (var searchItem in searchContent) {
  //         merchants.add(Merchant.fromJson(searchItem));
  //       }
  //
  //       MerchantService.setProviderMerchantList(context, merchants);
  //
  //       // push to search screen
  //       RoutingService.pushScreen(context, const SearchScreen());
  //     } else {
  //       // no search result found
  //       Helper.showInfoToast(context, "No search result found.");
  //     }
  //   });
  // }

  static void getProductList(context) async {
    Uri productListUrl = _getParsedSariEndpoint(
        "$kLocalHost/$kApiVersion/$kGetProductListRoute?maxResult=100&page=0");

    // start loading
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    http.Response sariResponse =
        await http.get(productListUrl, headers: _apiHeaders(true));

    _handleApiResponse(context, sariResponse.statusCode, () {
      var decodedSearch = jsonDecode(sariResponse.body)['body'];
      var productListContent = decodedSearch['content'];
      List<Product> products = [];

      if (!decodedSearch['empty']) {
        for (var product in productListContent) {
          products.add(Product.fromJson(product));
        }

        ProductService.setProviderProductList(context, products);
      } else {
        // no search result found
        Helper.showInfoToast(context, "No products yet");
      }
    });
  }

  static void getCategoryList(context) async {
    Uri categoryListUrl = _getParsedSariEndpoint(
        "$kLocalHost/$kApiVersion/$kGetCategoryListRoute?maxResult=100&page=0");

    // start loading
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    http.Response sariResponse =
        await http.get(categoryListUrl, headers: _apiHeaders(true));

    _handleApiResponse(context, sariResponse.statusCode, () {
      var decodedSearch = jsonDecode(sariResponse.body)['body'];
      var categoryListContent = decodedSearch['content'];
      List<ProductCategory> categories = [];

      if (!decodedSearch['empty']) {
        for (var category in categoryListContent) {
          categories.add(ProductCategory.fromJson(category));
        }

        ProductCategoryService.setProviderCategoryList(context, categories);
      } else {
        // no search result found
        Helper.showInfoToast(context, "No categories yet");
      }
    });
  }

  static void getSubCategoryList(context) async {
    Uri categoryListUrl = _getParsedSariEndpoint(
        "$kLocalHost/$kApiVersion/$kGetSubcategoryListRoute?&maxResult=100&page=0");

    // start loading
    EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);

    http.Response sariResponse =
        await http.get(categoryListUrl, headers: _apiHeaders(true));

    _handleApiResponse(context, sariResponse.statusCode, () {
      var decodedSearch = jsonDecode(sariResponse.body)['body'];
      var subCategoryListContent = decodedSearch['content'];
      List<ProductSubcategory> subcategories = [];

      if (!decodedSearch['empty']) {
        for (var subCategory in subCategoryListContent) {
          subcategories.add(ProductSubcategory.fromJson(subCategory));
        }

        ProductSubcategoryService.setProviderSubcategoryList(
            context, subcategories);
      } else {
        // no search result found
        Helper.showInfoToast(context, "No sub-categories yet");
      }
    });
  }

  static Uri _getParsedSariEndpoint(String route) {
    return Uri.parse(route);
  }

  static Map<String, String> _apiHeaders(bool includeToken) {
    Map<String, String> headers = {};

    headers[HttpHeaders.contentTypeHeader] = 'application/json';
    // include token only for protected routes
    if (includeToken) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $kToken';
    }

    return headers;
  }

  static void _handleApiResponse(context, status, onSuccess) {
    switch (status) {
      case HttpStatus.ok:
        onSuccess();
        break;
      case HttpStatus.unauthorized:
        Helper.showWarningToast(context, "Unauthorized request.");
        break;
      default:
        Helper.showErrorToast(
            context, "Oops, there was a problem requesting the data.");
        break;
    }

    // end loading
    EasyLoading.dismiss(animation: true);
  }
}
