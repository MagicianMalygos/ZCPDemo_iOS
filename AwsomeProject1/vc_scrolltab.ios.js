'use strict';
var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  NavigatorIOS,
} = React;

var MyScrollableTabView = require('./pages/MyScrollableTab');

var Index = React.createClass({
  render: function() {
    return (
      <NavigatorIOS style={[{flex:1}, ]} initialRoute={{title: '首页', component: MyScrollableTabView}}/>
    );
  },
});

AppRegistry.registerComponent('AwsomeProject', () => Index);
