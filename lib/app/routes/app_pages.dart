import 'package:get/get.dart';

import 'package:webcv/app/modules/About/bindings/about_binding.dart';
import 'package:webcv/app/modules/About/views/about_view.dart';
import 'package:webcv/app/modules/Admin/bindings/admin_binding.dart';
import 'package:webcv/app/modules/Admin/views/admin_view.dart';
import 'package:webcv/app/modules/Contact/bindings/contact_binding.dart';
import 'package:webcv/app/modules/Contact/views/contact_view.dart';
import 'package:webcv/app/modules/MyHomePage/bindings/my_home_page_binding.dart';
import 'package:webcv/app/modules/MyHomePage/views/my_home_page_view.dart';
import 'package:webcv/app/modules/Portfolio/bindings/portfolio_binding.dart';
import 'package:webcv/app/modules/Portfolio/views/portfolio_view.dart';
import 'package:webcv/app/modules/Project/bindings/project_binding.dart';
import 'package:webcv/app/modules/Project/views/project_view.dart';
import 'package:webcv/app/modules/Services/AppService/bindings/app_service_binding.dart';
import 'package:webcv/app/modules/Services/AppService/views/app_service_view.dart';
import 'package:webcv/app/modules/Services/WebService/bindings/web_service_binding.dart';
import 'package:webcv/app/modules/Services/WebService/views/web_service_view.dart';
import 'package:webcv/app/modules/memberCardPolicies/bindings/member_card_policies_binding.dart';
import 'package:webcv/app/modules/memberCardPolicies/views/member_card_policies_view.dart';
import 'package:webcv/app/modules/memberCardTerm/bindings/member_card_term_binding.dart';
import 'package:webcv/app/modules/memberCardTerm/views/member_card_term_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    // GetPage(
    //   name: _Paths.MY_HOME_PAGE,
    //   page: () => MyHomePageView(),
    //   binding: MyHomePageBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PORTFOLIO,
    //   page: () => PortfolioView(),
    //   binding: PortfolioBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ABOUT,
    //   page: () => AboutView(),
    //   binding: AboutBinding(),
    // ),
    // GetPage(
    //   name: _Paths.CONTACT,
    //   page: () => ContactView(),
    //   binding: ContactBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ADMIN,
    //   page: () => AdminView(),
    //   binding: AdminBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SERVICES,
    //   page: () => ServicesView(),
    //   binding: ServicesBinding(),
    // ),
    // GetPage(
    //   name: _Paths.PROJECT,
    //   page: () => ProjectView(),
    //   binding: ProjectBinding(),
    // ),
    // GetPage(
    //   name: _Paths.APP_SERVICE,
    //   page: () => AppServiceView(),
    //   binding: AppServiceBinding(),
    // ),
    // GetPage(
    //   name: _Paths.WEB_SERVICE,
    //   page: () => WebServiceView(),
    //   binding: WebServiceBinding(),
    // ),
    GetPage(
      name: _Paths.MEMBER_CARD_POLICIES,
      page: () => MemberCardPoliciesView(),
      binding: MemberCardPoliciesBinding(),
    ),
    GetPage(
      name: _Paths.MEMBER_CARD_TERM,
      page: () => MemberCardTermView(),
      binding: MemberCardTermBinding(),
    ),
  ];
}
