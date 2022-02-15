import 'package:get/get.dart';
import '../controllers/controller.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ContactController());
  }
}
