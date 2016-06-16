/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

// require：用来引入其他模块，类似与import或者include
var React = require('react-native');

// 批量定义组件(语法糖)：等同于
/*
var AppRegistry = React.AppRegistry;
var StyleSheet = React.StyleSheet;
var Text = React.Text;
var View = React.View;
*/
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ScrollView,
} = React;

var Article = React.createClass({
  render: function() {
    return (
      <View style={[article_styles.container]}>
        <Text style={[article_styles.text, article_styles.title]}>{this.props.title}</Text>
        <Text style={article_styles.text}>{this.props.author}</Text>
        <Text style={article_styles.text}>{this.props.time}</Text>
      </View>
    );
  }
});
var article_styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 40,
  },
  text: {
    color: 'red',
  },
  title: {

  },
});




// 使用createClass创建入口类，
var Index = React.createClass({

  /*
    组件的生命周期：
    componentWillMount：组件创建前
    getInitialState：初始化状态
    render：渲染视图
    componentDidMount：渲染视图完成后
    componentWillUnmount：组件被卸载之前
  */

  componentWillMount: function() {

  },

  getInitialState: function() {
    var data = [
      {"title":"1", "author":"zcp1", "time":"00:00:01"},
      {"title":"2", "author":"zcp2", "time":"00:00:02"},
      {"title":"3", "author":"zcp3", "time":"00:00:03"}
    ];
    return {
      articles: data
    };
  },

  // render：渲染视图，返回视图的模板代码 JSX的模板语言
  render: function() {
    // 最外层只能有一个View
    return (
      <ScrollView>
        {
          this.state.articles.map( function(article) {
            return <Article title={article.title} author={article.author} time={article.time}/>
          })
        }
      </ScrollView>
    );
  },

  componentDidMount: function() {

  },
  componentWillUnmount: function() {

  }
});



// 注册应用入口
AppRegistry.registerComponent('AwsomeProject', () => Index);
