import 'package:client/models/category_icon_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryIcons {
  final List<CategoryIconModel> categoryIcons = [
    CategoryIconModel(
      icon: SvgPicture.asset("assets/svg/icon_smartphone.svg"),
      enName: "smartphone",
      koName: "스마트폰",
    ),
    CategoryIconModel(
      icon: SvgPicture.asset("assets/svg/icon_wallet.svg"),
      enName: "wallet",
      koName: "지갑",
    ),
    CategoryIconModel(
      icon: SvgPicture.asset("assets/svg/icon_earphones.svg"),
      enName: "earphones",
      koName: "이어폰",
    ),
    CategoryIconModel(
      icon: SvgPicture.asset("assets/svg/icon_watch.svg"),
      enName: "watch",
      koName: "시계",
    ),
    CategoryIconModel(
      icon: SvgPicture.asset("assets/svg/icon_accessory.svg"),
      enName: "accessory",
      koName: "악세서리",
    ),
    CategoryIconModel(
      icon: SvgPicture.asset("assets/svg/icon_etc.svg"),
      enName: "etc",
      koName: "기타",
    ),
  ];
}
