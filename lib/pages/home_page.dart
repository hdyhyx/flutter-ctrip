import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
const APPBAR_OFFSET=100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _swiperImages = [
    'http://y.gtimg.cn/music/common/upload/MUSIC_FOCUS/1707182.jpg',
    'http://y.gtimg.cn/music/common/upload/MUSIC_FOCUS/1709995.jpg',
    'http://y.gtimg.cn/music/common/upload/MUSIC_FOCUS/1707559.jpg'
  ];
  double appBarAlpha = 0;
  _onScroll(offset){
     double alpha = offset / APPBAR_OFFSET;
    if(alpha<0) {
      alpha=0;
    }
    if(alpha>1){
      alpha=1;
    }
    setState(() {
      appBarAlpha=alpha;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding( context: context,
            removeTop: true,
            child:  NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification){
                if( notification is ScrollUpdateNotification &&  notification.depth==0 ){
                  _onScroll(notification.metrics.pixels);
                }
                return true;
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount:_swiperImages.length ,
                      itemBuilder:(BuildContext context, int index){
                        return new Image.network(_swiperImages[index],fit: BoxFit.fill);
                      } ,
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('首页'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
