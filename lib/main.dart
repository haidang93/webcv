import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webcv/app/modules/About/controllers/about_controller.dart';
import 'package:webcv/app/modules/About/views/about_view.dart';
import 'package:webcv/app/modules/Admin/controllers/admin_controller.dart';
import 'package:webcv/app/modules/Admin/views/admin_view.dart';
import 'package:webcv/app/modules/Contact/controllers/contact_controller.dart';
import 'package:webcv/app/modules/Contact/views/contact_view.dart';
import 'package:webcv/app/modules/MyHomePage/views/my_home_page_view.dart';
import 'package:webcv/app/modules/Portfolio/controllers/portfolio_controller.dart';
import 'package:webcv/app/modules/Portfolio/views/portfolio_detail.dart';
import 'package:webcv/app/modules/Project/controllers/project_controller.dart';
import 'package:webcv/app/modules/Project/views/project_view.dart';
import 'package:webcv/app/modules/Services/AppService/controllers/app_service_controller.dart';
import 'package:webcv/app/modules/Services/AppService/views/app_service_view.dart';
import 'package:webcv/app/modules/Services/WebService/controllers/web_service_controller.dart';
import 'package:webcv/app/modules/Services/WebService/views/web_service_view.dart';
import 'package:webcv/app/modules/Services/service/controllers/services_controller.dart';
import 'package:webcv/app/modules/memberCardPolicies/controllers/member_card_policies_controller.dart';
import 'package:webcv/app/modules/memberCardPolicies/views/member_card_policies_view.dart';
import 'package:webcv/app/modules/memberCardTerm/controllers/member_card_term_controller.dart';
import 'package:webcv/app/modules/memberCardTerm/views/member_card_term_view.dart';
import 'package:webcv/app/modules/news_preview/controllers/news_preview_controller.dart';
import 'package:webcv/app/modules/news_preview/views/news_preview_view.dart';

import 'app/modules/MyHomePage/controllers/my_home_page_controller.dart';
import 'app/modules/Portfolio/views/portfolio_view.dart';
import 'app/modules/Services/service/views/services_view.dart';
import 'common/const.dart';

String newsId = '0';
NewsType newsType = NewsType.NEWS;
enum NewsType { CEO, NEWS }

const ceoMsg = 'ceo_msg';
const news = 'news';

void main() async {
  WebRouterDelegate routerDelegate = WebRouterDelegate();
  WebRouteInformationParser informationParser = WebRouteInformationParser();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Nguyen Hai Dang Mobile App Devoloper',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routeInformationParser: informationParser,
      routerDelegate: routerDelegate,
    ),
  );
}

class PageToLoad {
  final String pageName;
  PageToLoad(this.pageName);
}

class WebRouteInformationParser extends RouteInformationParser<WebRoutePath> {
  @override
  Future<WebRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return WebRoutePath.home();
    }
    if (uri.pathSegments.length == 1)
      switch (uri.pathSegments[0]) {
        case PageName.home:
          return WebRoutePath.home();
          break;
        case PageName.portfolio:
          return WebRoutePath.portfolio();
          break;
        case PageName.portfolioDetail:
          return WebRoutePath.portfolioDetail();
          break;
        case PageName.contact:
          return WebRoutePath.contact();
          break;
        case PageName.about:
          return WebRoutePath.about();
          break;
        case PageName.admin:
          return WebRoutePath.admin();
          break;
        case PageName.services:
          return WebRoutePath.services();
          break;
        case PageName.project:
          return WebRoutePath.project();
          break;
        case PageName.memberPrivacy:
          return WebRoutePath.memberPrivacy();
          break;
        case PageName.memberterm:
          return WebRoutePath.memberterm();
          break;
        default:
          // return WebRoutePath.unknown();
          break;
      }
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == PageName.services) {
        switch (uri.pathSegments[1]) {
          case 'web-app-design':
            return WebRoutePath.webservice();
            break;
          case 'mobile-app-development':
            return WebRoutePath.appservice();
            break;

          default:
            // return WebRoutePath.unknown();
            break;
        }
      }
      if (uri.pathSegments[0] == PageName.portfolio) {
        switch (uri.pathSegments[1]) {
          case 'detail':
            return WebRoutePath.portfolioDetail();
            break;
          default:
            break;
        }
      }
      if (uri.pathSegments[0] == PageName.newsPreview) {
        newsId = uri.pathSegments[1];
        return WebRoutePath.newsPreview();
      }
      if (uri.pathSegments[0] == 'member-cards') {
        switch (uri.pathSegments[1]) {
          case PageName.memberPrivacy:
            return WebRoutePath.memberPrivacy();
            break;
          case PageName.memberterm:
            return WebRoutePath.memberterm();
            break;
          default:
            break;
        }
      }
    }
    if (uri.pathSegments.length == 3) {
      if (uri.pathSegments[0] == PageName.newsPreview) {
        if (uri.pathSegments[1] == ceoMsg) {
          newsType = NewsType.CEO;
        } else if (uri.pathSegments[1] == news) {
          newsType = NewsType.NEWS;
        }
        newsId = uri.pathSegments[2];
        return WebRoutePath.newsPreview();
      }
    }
    return WebRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(WebRoutePath path) {
    if (path.pageName == PageName.notFound) {
      return RouteInformation(location: '/404');
    }
    if (path.pageName == PageName.home) {
      return RouteInformation(location: '/home');
    }
    if (path.pageName == PageName.portfolio) {
      return RouteInformation(location: '/portfolio');
    }
    if (path.pageName == PageName.portfolioDetail) {
      return RouteInformation(location: '/portfolio/detail');
    }
    if (path.pageName == PageName.contact) {
      return RouteInformation(location: '/contact');
    }
    if (path.pageName == PageName.about) {
      return RouteInformation(location: '/about');
    }
    if (path.pageName == PageName.admin) {
      return RouteInformation(location: '/admin');
    }
    if (path.pageName == PageName.services) {
      return RouteInformation(location: '/services');
    }
    if (path.pageName == PageName.project) {
      return RouteInformation(location: '/project');
    }
    if (path.pageName == PageName.appservice) {
      return RouteInformation(location: '/services/mobile-app-development');
    }
    if (path.pageName == PageName.webservice) {
      return RouteInformation(location: '/services/web-app-design');
    }
    if (path.pageName == PageName.memberPrivacy) {
      return RouteInformation(location: '/member-cards/PrivacyPolicy');
    }
    if (path.pageName == PageName.memberterm) {
      return RouteInformation(location: '/member-cards/TermsService');
    }
    if (path.pageName == PageName.newsPreview) {
      if (newsType == NewsType.CEO)
        return RouteInformation(location: '/newsPreview/$ceoMsg/$newsId');
      if (newsType == NewsType.NEWS)
        return RouteInformation(location: '/newsPreview/$news/$newsId');
    }
    return null;
  }
}

String handleTap;

class WebRouterDelegate extends RouterDelegate<WebRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WebRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  bool show404 = false;
  PageToLoad page;

  WebRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  WebRoutePath get currentConfiguration {
    if (show404) {
      return WebRoutePath.unknown();
    }
    if (page == null) {
      return WebRoutePath.home();
    } else {
      if (page.pageName == PageName.home) {
        return WebRoutePath.home();
      }
      if (page.pageName == PageName.portfolio) {
        return WebRoutePath.portfolio();
      }
      if (page.pageName == PageName.portfolioDetail) {
        return WebRoutePath.portfolioDetail();
      }
      if (page.pageName == PageName.contact) {
        return WebRoutePath.contact();
      }
      if (page.pageName == PageName.about) {
        return WebRoutePath.about();
      }
      if (page.pageName == PageName.admin) {
        return WebRoutePath.admin();
      }
      if (page.pageName == PageName.services) {
        return WebRoutePath.services();
      }
      if (page.pageName == PageName.project) {
        return WebRoutePath.project();
      }
      if (page.pageName == PageName.appservice) {
        return WebRoutePath.appservice();
      }
      if (page.pageName == PageName.webservice) {
        return WebRoutePath.webservice();
      }
      if (page.pageName == PageName.memberPrivacy) {
        return WebRoutePath.memberPrivacy();
      }
      if (page.pageName == PageName.memberterm) {
        return WebRoutePath.memberterm();
      }
      if (page.pageName == PageName.newsPreview) {
        return WebRoutePath.newsPreview();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    paging = handleTapped;
    switch (page?.pageName ?? '') {
      case PageName.home:
        Get.lazyPut<MyHomePageController>(
          () => MyHomePageController(),
        );
        break;
      case PageName.about:
        Get.lazyPut<AboutController>(
          () => AboutController(),
        );
        break;
      case PageName.admin:
        Get.lazyPut<AdminController>(
          () => AdminController(),
        );
        break;
      case PageName.contact:
        Get.lazyPut<ContactController>(
          () => ContactController(),
        );
        break;
      case PageName.portfolio:
        Get.lazyPut<PortfolioController>(
          () => PortfolioController(),
        );
        break;
      case PageName.portfolioDetail:
        Get.lazyPut<PortfolioController>(
          () => PortfolioController(),
        );
        break;
      case PageName.project:
        Get.lazyPut<ProjectController>(
          () => ProjectController(),
        );
        break;
      case PageName.services:
        Get.lazyPut<ServicesController>(
          () => ServicesController(),
        );
        break;
      case PageName.appservice:
        Get.lazyPut<AppServiceController>(
          () => AppServiceController(),
        );
        break;
      case PageName.webservice:
        Get.lazyPut<WebServiceController>(
          () => WebServiceController(),
        );
        break;
      case PageName.memberPrivacy:
        Get.lazyPut<MemberCardPoliciesController>(
          () => MemberCardPoliciesController(),
        );
        break;
      case PageName.memberterm:
        Get.lazyPut<MemberCardTermController>(
          () => MemberCardTermController(),
        );
        break;
      case PageName.newsPreview:
        Get.lazyPut<NewsPreviewController>(
          () => NewsPreviewController(),
        );
        break;
      default:
        Get.lazyPut<MyHomePageController>(
          () => MyHomePageController(),
        );
        break;
    }
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey(PageName.home),
          child: MyHomePageView(),
        ),
        if (show404)
          MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnknownPage(),
          )
        else if (page != null)
          if (page.pageName == PageName.portfolio)
            MaterialPage(
              key: ValueKey(PageName.portfolio),
              child: PortfolioView(),
            )
          else if (page.pageName == PageName.portfolioDetail)
            MaterialPage(
              key: ValueKey(PageName.portfolioDetail),
              child: PortfolioDetail(),
            )
          else if (page.pageName == PageName.about)
            MaterialPage(
              key: ValueKey(PageName.about),
              child: AboutView(),
            )
          else if (page.pageName == PageName.contact)
            MaterialPage(
              key: ValueKey(PageName.contact),
              child: ContactView(),
            )
          else if (page.pageName == PageName.admin)
            MaterialPage(
              key: ValueKey(PageName.admin),
              child: AdminView(),
            )
          else if (page.pageName == PageName.services)
            MaterialPage(
              key: ValueKey(PageName.services),
              child: ServicesView(),
            )
          else if (page.pageName == PageName.project)
            MaterialPage(
              key: ValueKey(PageName.project),
              child: ProjectView(),
            )
          else if (page.pageName == PageName.appservice)
            MaterialPage(
              key: ValueKey(PageName.appservice),
              child: AppServiceView(),
            )
          else if (page.pageName == PageName.webservice)
            MaterialPage(
              key: ValueKey(PageName.webservice),
              child: WebServiceView(),
            )
          else if (page.pageName == PageName.memberPrivacy)
            MaterialPage(
              key: ValueKey(PageName.memberPrivacy),
              child: MemberCardPoliciesView(),
            )
          else if (page.pageName == PageName.memberterm)
            MaterialPage(
              key: ValueKey(PageName.memberterm),
              child: MemberCardTermView(),
            )
          else if (page.pageName == PageName.newsPreview)
            MaterialPage(
              key: ValueKey(PageName.newsPreview),
              child: NewsPreviewView(),
            ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedBook to null
        page = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(WebRoutePath path) async {
    show404 = false;
    if (path.pageName == PageName.home) {
      page = null;
    } else if (path.pageName == PageName.portfolio) {
      page = PageToLoad(PageName.portfolio);
    } else if (path.pageName == PageName.portfolioDetail) {
      page = PageToLoad(PageName.portfolioDetail);
    } else if (path.pageName == PageName.contact) {
      page = PageToLoad(PageName.contact);
    } else if (path.pageName == PageName.about) {
      page = PageToLoad(PageName.about);
    } else if (path.pageName == PageName.admin) {
      page = PageToLoad(PageName.admin);
    } else if (path.pageName == PageName.services) {
      page = PageToLoad(PageName.services);
    } else if (path.pageName == PageName.project) {
      page = PageToLoad(PageName.project);
    } else if (path.pageName == PageName.appservice) {
      page = PageToLoad(PageName.appservice);
    } else if (path.pageName == PageName.webservice) {
      page = PageToLoad(PageName.webservice);
    } else if (path.pageName == PageName.memberPrivacy) {
      page = PageToLoad(PageName.memberPrivacy);
    } else if (path.pageName == PageName.memberterm) {
      page = PageToLoad(PageName.memberterm);
    } else if (path.pageName == PageName.newsPreview) {
      page = PageToLoad(PageName.newsPreview);
    } else {
      show404 = true;
    }
  }

  void handleTapped(String name) {
    final page = PageToLoad(name);
    this.page = page;
    notifyListeners();
  }
}

class WebRoutePath {
  String pageName;

  WebRoutePath.home() : pageName = PageName.home;
  WebRoutePath.portfolio() : pageName = PageName.portfolio;
  WebRoutePath.portfolioDetail() : pageName = PageName.portfolioDetail;
  WebRoutePath.contact() : pageName = PageName.contact;
  WebRoutePath.about() : pageName = PageName.about;
  WebRoutePath.admin() : pageName = PageName.admin;
  WebRoutePath.services() : pageName = PageName.services;
  WebRoutePath.project() : pageName = PageName.project;
  WebRoutePath.appservice() : pageName = PageName.appservice;
  WebRoutePath.webservice() : pageName = PageName.webservice;
  WebRoutePath.memberPrivacy() : pageName = PageName.memberPrivacy;
  WebRoutePath.memberterm() : pageName = PageName.memberterm;
  WebRoutePath.newsPreview() : pageName = PageName.newsPreview;
  WebRoutePath.unknown() : pageName = PageName.notFound;
}

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Text('Page not found'),
      ),
    );
  }
}

class PageName {
  static const String home = 'home';
  static const String portfolio = 'portfolio';
  static const String portfolioDetail = 'portfolioDetail';
  static const String contact = 'contact';
  static const String about = 'about';
  static const String admin = 'admin';
  static const String services = 'services';
  static const String project = 'project';
  static const String appservice = 'appservice';
  static const String webservice = 'webservice';
  static const String memberPrivacy = 'PrivacyPolicy';
  static const String memberterm = 'TermsService';
  static const String newsPreview = 'newsPreview';
  static const String notFound = '404';
}
