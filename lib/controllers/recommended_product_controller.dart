import 'package:get/get.dart';
import 'package:restaurants_app/data/repository/recommended_product_repo.dart';
import 'package:restaurants_app/models/product_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList()async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got product");
      _recommendedProductList =[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(_recommendedProductList);
      _isLoaded = true;
      update();
    }
  }
}