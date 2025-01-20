import 'package:bouncy_bargain/data/repositories/banner/banner_repositories.dart';
import 'package:bouncy_bargain/features/shop/models/banner_model.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  // Variables
  final carouselCurrentIndex = 0.obs; // Current index for carousel (banner)
  final isLoading = false.obs; // Loading state flag
  final RxList<BannerModel> banners = <BannerModel>[].obs; // List to hold banners

  final _repo = Get.put(BannerRepositories()); // Repository instance for banner fetching and uploading

  @override
  void onInit() {
    super.onInit();
    fetchBanners(); // Fetch banners on controller initialization
  }

  // Update carousel index (for page indicator)
  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  // Fetch banners from the repository
  Future<void> fetchBanners() async {
    try {
      // Show loader while fetching banners
      isLoading.value = true;
      final fetchedBanners = await _repo.fetchBanners();

      // Update the banners list with fetched data
      banners.assignAll(fetchedBanners);
    } catch (e) {
      // Display error message if fetching banners fails
      XLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove loader after fetching banners
      isLoading.value = false;
    }
  }

  // Upload dummy banners data (for testing purposes)
  Future<void> uploadBanners() async {
    try {
      // Show loader while uploading banners
      isLoading.value = true;
      await _repo.uploadDummyData(); // Upload dummy banner data
    } catch (e) {
      // Display error message if uploading banners fails
      XLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove loader after uploading
      isLoading.value = false;
    }
  }
}
