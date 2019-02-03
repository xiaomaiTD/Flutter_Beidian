import 'package:zbflutter/Global/ZBGlobalHeader.dart';
import 'package:zbflutter/Module/BDHome.dart';
import 'package:zbflutter/Module/BDDiscovery.dart';
import 'package:zbflutter/Module/BDMember.dart';
import 'package:zbflutter/Module/BDShoppingCart.dart';
import 'package:zbflutter/Module/BDStore.dart';


class ZBTabBarWidget extends StatefulWidget {
  _ZBTabBarWidgetState createState() => _ZBTabBarWidgetState();
}

class _ZBTabBarWidgetState extends State<ZBTabBarWidget> {
  int _currentTabBarIndex = 0;
  List<Widget> _widgetList = List();

  @override
  void initState() {
    _widgetList
      ..add(BDHomeWidget())
      ..add(BDDiscoveryWidget())
      ..add(BDStoreWidget())
      ..add(BDShoppingCartWidget())
      ..add(BDMemberWidget());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [];
    List<Map<String, String>> iconInfos = [
      {
        'title': '今日特卖',
        'icon': 'images/ic_tabbar_home_nor.png',
        'icon_seleted': 'images/ic_tabbar_home_sel.png'
      },
      {
        'title': '社区',
        'icon': 'images/ic_tabbar_community_nor.png',
        'icon_seleted': 'images/ic_tabbar_community_sel.png'
      },
      {
        'title': '我的店',
        'icon': 'images/ic_tabbar_stores_nor.png',
        'icon_seleted': 'images/ic_tabbar_stores_sel.png'
      },
      {
        'title': '购物车',
        'icon': 'images/ic_tabbar_cart_nor.png',
        'icon_seleted': 'images/ic_tabbar_cart_sel.png'
      },
      {
        'title': '个人中心',
        'icon': 'images/ic_tabbar_mine_nor.png',
        'icon_seleted': 'images/ic_tabbar_mine_sel.png'
      }
    ];
    for (Map<String, String> item in iconInfos) {

      var iconName = iconInfos.indexOf(item) == _currentTabBarIndex ? item['icon_seleted'] : item ['icon'];
      var titleColor = iconInfos.indexOf(item) == _currentTabBarIndex ? BDColor.beidianRedColor: Color(0xFF5C5C5C);

      items.add(BottomNavigationBarItem(
          icon: Image.asset(
            iconName,
            width: 22,
            height: 22,
            fit: BoxFit.scaleDown,
          ),
          title: Text(item['title'],
              style: TextStyle(color: titleColor, fontSize: 11))));
    }

    return Scaffold(
      body: _widgetList[_currentTabBarIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentTabBarIndex = index;
            });
          },
          currentIndex: _currentTabBarIndex,
          items: items,
          type: BottomNavigationBarType.fixed),
    );
  }
}
