/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

// require：用来引入其他模块，类似与import或者include
var React = require('react-native');
// var Swiper = require('react-native-swiper');

// 批量定义组件(语法糖)：等同于
/*
var AppRegistry = React.AppRegistry;
var StyleSheet = React.StyleSheet;
var Text = React.Text;
var View = React.View;
*/
var {
  StyleSheet,
  Text,
  View,
  Image,
  TouchableHighlight,
  ScrollView,
} = React;

// Slider
// var sliderImgs = [
//   'http://images3.c-ctrip.com/SBU/apph5/201505/16/app_home_ad16_640_128.png',
//   'http://images3.c-ctrip.com/rk/apph5/C1/201505/app_home_ad49_640_128.png',
//   'http://images3.c-ctrip.com/rk/apph5/D1/201506/app_home_ad05_640_128.jpg'
// ];
var BUIcon = [
  'https://raw.githubusercontent.com/vczero/vczero.github.io/master/ctrip/%E6%9C%AA%E6%A0%87%E9%A2%98-1.png',
  'https://raw.githubusercontent.com/vczero/vczero.github.io/master/ctrip/feiji.png',
  'https://raw.githubusercontent.com/vczero/vczero.github.io/master/ctrip/lvyou.png',
  'https://raw.githubusercontent.com/vczero/vczero.github.io/master/ctrip/gonglue.png'
];
var Images = [
  'http://webresource.c-ctrip.com/ResCRMOnline/R5/html5/images/zzz_pic_salead01.png',
  'http://images3.c-ctrip.com/rk/apph5/B1/201505/app_home_ad06_310_120.jpg'
];
// var sliderImgs = [
//   'http://images3.c-ctrip.com/SBU/apph5/201505/16/app_home_ad16_640_128.png',
//   'http://images3.c-ctrip.com/rk/apph5/C1/201505/app_home_ad49_640_128.png',
//   'http://images3.c-ctrip.com/rk/apph5/D1/201506/app_home_ad05_640_128.jpg'
// ];

// var Slider = React.createClass({
//   render: function() {
//     return (
//       <Swiper style={[{height: 80}, ]} showsButtons={false} autoplay={true} height={150} showsPagination={false}>
//         <Image style={[{}, styles.slide]} source={{uri: sliderImgs[0]}}></Image>
//         <Image style={[{}, styles.slide]} source={{uri: sliderImgs[1]}}></Image>
//         <Image style={[{}, styles.slide]} source={{uri: sliderImgs[2]}}></Image>
//       </Swiper>
//     );
//   }
// });



// 使用createClass创建入口类，
var xcContent = React.createClass({

  // render：渲染视图，返回视图的模板代码 JSX的模板语言
  render: function() {
    // 最外层只能有一个View
    return (
      <ScrollView style={[{backgroundColor: '#F8F8FF'}, ]}>
      <View style={[{}, styles.container]}>
        <View style={[{}, styles.sub_view, styles.sub_red]}>
          <TouchableHighlight style={[{flex: 1}, ]} underlayColor={'#FA6778'}>
            <View style={[{flex: 1}, styles.sub_borderRight]}>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Text style={[{}, styles.sub_textFont]}>酒店</Text>
              </View>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Image style={[{}, styles.sub_icon_img]} source={{uri: BUIcon[0]}}></Image>
              </View>
            </View>
          </TouchableHighlight>
          <View style={[{flex: 1}, styles.sub_borderRight]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>海外</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>周边</Text>
            </View>
          </View>
          <View style={[{flex: 1}, ]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>团购.特惠</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>客栈.公寓</Text>
            </View>
          </View>
        </View>


        <View style={[{}, styles.sub_view, styles.sub_blue]}>
          <TouchableHighlight style={[{flex: 1}, ]} underlayColor={'#FA6778'}>
            <View style={[{flex: 1}, styles.sub_borderRight]}>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Text style={[{}, styles.sub_textFont]}>机票</Text>
              </View>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Image style={[{}, styles.sub_icon_img]} source={{uri: BUIcon[1]}}></Image>
              </View>
            </View>
          </TouchableHighlight>
          <View style={[{flex: 1}, styles.sub_borderRight]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>火车票</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>接收机</Text>
            </View>
          </View>
          <View style={[{flex: 1}, ]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>汽车票</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>自驾.专车</Text>
            </View>
          </View>
        </View>


        <View style={[{}, styles.sub_view, styles.sub_green]}>
          <TouchableHighlight style={[{flex: 1}, ]} underlayColor={'#FA6778'}>
            <View style={[{flex: 1}, styles.sub_borderRight]}>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Text style={[{}, styles.sub_textFont]}>旅游</Text>
              </View>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Image style={[{}, styles.sub_icon_img]} source={{uri: BUIcon[2]}}></Image>
              </View>
            </View>
          </TouchableHighlight>
          <View style={[{flex: 1}, styles.sub_borderRight]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>门票.玩乐</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>出境WiFi</Text>
            </View>
          </View>
          <View style={[{flex: 1}, ]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>游轮</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>签证</Text>
            </View>
          </View>
        </View>


        <View style={[{}, styles.sub_view, styles.sub_yellow]}>
          <TouchableHighlight style={[{flex: 1}, ]} underlayColor={'#FA6778'}>
            <View style={[{flex: 1}, styles.sub_borderRight]}>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Text style={[{}, styles.sub_textFont]}>攻略</Text>
              </View>
              <View style={[{flex: 1}, styles.sub_align]}>
                <Image style={[{}, styles.sub_icon_img]} source={{uri: BUIcon[3]}}></Image>
              </View>
            </View>
          </TouchableHighlight>
          <View style={[{flex: 1}, styles.sub_borderRight]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>周末游</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>礼品卡</Text>
            </View>
          </View>
          <View style={[{flex: 1}, ]}>
            <View style={[{flex: 1}, styles.sub_align, styles.sub_borderBottom]}>
              <Text style={[{}, styles.sub_textFont]}>美食.购物</Text>
            </View>
            <View style={[{flex: 1}, styles.sub_align]}>
              <Text style={[{}, styles.sub_textFont]}>更多</Text>
            </View>
          </View>
        </View>

        <View style={[{flex: 1}, styles.other_view]}>
          <View style={[{flex: 1, borderWidth:1, borderColor: '#ccc'}, ]}>
            <Image style={[{resizeMode:Image.resizeMode.contain, height: 59}, ]} source={{uri: Images[0]}}></Image>
          </View>
          <View style={[{flex: 1, borderWidth:1, borderColor: '#ccc'}, ]}>
            <Image style={[{resizeMode:Image.resizeMode.contain, height: 59}, ]} source={{uri: Images[1]}}></Image>
          </View>
        </View>
      </View>
      </ScrollView>
    );
  }
});

// 创建样式
var styles = StyleSheet.create({
  container: {
    backgroundColor:'#F2F2F2',
    flex:1
  },
  // Slider
  // slide: {
  //   height:80,
  //   resizeMode: Image.resizeMode.contain
  // },
  // Sub
  sub_view: {
    height: 85,
    marginLeft: 5,
    marginRight: 5,
    borderWidth: 1,
    borderRadius: 5,
    marginBottom: 10,
    flexDirection: 'row'
  },
  sub_red: {
    backgroundColor: '#FA6778',
    borderColor: '#FA6778',
    marginTop: 20
  },
  sub_blue: {
    backgroundColor: '#3D98FF',
    borderColor: '#3D98FF'
  },
  sub_green: {
    backgroundColor: '#5EBE00',
    borderColor: '#5EBE00'
  },
  sub_yellow: {
    backgroundColor: '#FC9720',
    borderColor: '#FC9720'
  },
  sub_borderRight: {
    borderRightWidth: 0.5,
    borderColor: '#FFFFFF'
  },
  sub_borderBottom: {
    borderBottomWidth: 0.5,
    borderColor: '#FFFFFF'
  },
  sub_align: {
    justifyContent: 'center',
    alignItems: 'center'
  },
  sub_textFont: {
    fontSize: 17,
    color: '#FFFFFF',
    fontWeight: '900'
  },
  sub_icon_img: {
    height: 40,
    width: 40,
    resizeMode:Image.resizeMode.contain
  },

  other_view: {
    height: 62,
    marginLeft: 5,
    marginRight: 5,
    marginBottom: 20,
    backgroundColor: '#fff',
    flexDirection: 'row'
  },
});

// 注册应用入口
module.exports = xcContent;
