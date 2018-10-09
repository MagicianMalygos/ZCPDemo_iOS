'use strict'

var React = require('react');
var ReactNative = require('react-native');
var {Component, PropTypes} = React;
var {StyleSheet, View, Text} = ReactNative;

export default class Case2 extends Component {
  render() {
    return(
      <View style={{flex: 1, marginBottom: 64}}>
        <Header/>
        <List title='宇航员在太空宣布“三体”获奖'/>
        <List title='NASA发短片几年火星征程50周年'/>
        <List title='男生连续做一周苦瓜吃吐女友'/>
        <List title='女童遭鲨鱼袭击又下海救伙伴'/>
        <ImportanceNews news={[
          '1、刘慈欣《三体》获“雨果奖”，为中国作家首次获得',
          '2、京津冀协同发展定位明确：北京没有经济中心表述',
          '3、好奇宝宝第一次淋雨，他的父亲用镜头记录了下来',
          '4、人民邮电出版社即将出版《React Native入门与实战》，读者可以使用JavaScript开发原生应用，你想要买一本看看吗？',
        ]}/>
      </View>
    );
  }
}

// header
var Header = React.createClass({
  render() {
    return(
      <View style={styles.head}>
        <Text style={styles.font}>
          <Text style={styles.font_1}>網易</Text>
          <Text style={styles.font_2}>新闻</Text>
          <Text>有态度</Text>
        </Text>
      </View>
    );
  }
});

// list
var List = React.createClass({
  render() {
    return(
      <View style={styles.list_item}>
        <Text style={styles.list_item_font}>{this.props.title}</Text>
      </View>
    );
  }
});

// importance news
var ImportanceNews = React.createClass({
  show(title) {
    alert(title);
  },
  render() {
    var cNews = [];
    for (var i in this.props.news) {
      /*
        这里添加的key是为了优化性能：
        我们应该为每一child以及在child中的所有child都增加这个key属性，
        这么做能最大程度地减小虚拟DOM变化产生的性能开销，只更新虚拟dom的一小部分，
        从而达到优化性能的目的
        http://stackoverflow.com/questions/28329382/understanding-unique-keys-for-array-children-in-react-js#answer-28329550
      */
      var cNew = (
        <Text
          onPress={this.show.bind(this, this.props.news[i])}
          numberOfLines={2}
          style={styles.news_item}
          key={i}>
          {this.props.news[i]}
        </Text>
      );
      cNews.push(cNew);
    }
    return(
      <View style={styles.flex}>
        <Text style={styles.news_item}>今日要闻</Text>
        {cNews}
      </View>
    );
  }
});

var styles = StyleSheet.create({
  flex: {
    flex: 1,
  },
  head: {
    marginTop: 25,
    height: 50,
    borderBottomWidth: 3 / ReactNative.PixelRatio.get(),
    borderBottomColor: '#ef2d36',
    alignItems: 'center',
  },
  font: {
    fontSize: 25,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  font_1: {
    color: '#cd1d1c',
  },
  font_2: {
    color: '#ffffff',
    backgroundColor: '#cd1d1c',
  },

  list_item: {
    height: 40,
    marginLeft: 10,
    marginRight: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
    justifyContent: 'center',
  },
  list_item_font: {
    fontSize: 16,
  },
  news_title: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#cd1d1c',
    marginLeft: 10,
    marginTop: 15,
  },
  news_item: {
    marginLeft: 10,
    marginRight: 10,
    fontSize: 15,
    lineHeight: 20,
  },
});
