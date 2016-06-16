'use strict';
var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ScrollView,
} = React;

var ScrollableTabView = require('react-native-scrollable-tab-view');
var FacebookTabBar = require('./FacebookTabBar');

var MyScrollableTabView = React.createClass({
  render: function() {
    return (
      <View style={styles.container}>
        <ScrollableTabView initialPage={1} renderTabBar={() => <FacebookTabBar/>}>
          {/*<ScrollView tabLabel='对对联' style={styles.tabView}>
            <View style={styles.card}>
              <Text>News</Text>
            </View>
          </ScrollView>

          <ScrollView tabLabel='舌场争锋' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Friends</Text>
            </View>
          </ScrollView>

          <ScrollView tabLabel='头脑风暴' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Messenger</Text>
            </View>
          </ScrollView>*/}

          <ScrollView tabLabel='ion|ios-paper' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Icon</Text>
            </View>
          </ScrollView>
          <ScrollView tabLabel='ion|person-stalker' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Icon</Text>
            </View>
          </ScrollView>
          <ScrollView tabLabel='ion|ios-chatboxes' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Icon</Text>
            </View>
          </ScrollView>
          <ScrollView tabLabel='ion|ios-world' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Icon</Text>
            </View>
          </ScrollView>
          <ScrollView tabLabel='ion|navicon-round' style={styles.tabView}>
            <View style={styles.card}>
              <Text>Icon</Text>
            </View>
          </ScrollView>
        </ScrollableTabView>
      </View>
    );
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 64,
  },
  tabView: {
    flex: 1,
    padding: 10,
    backgroundColor: 'rgba(0,0,0,0.01)',
  },
  card: {
    borderWidth: 1,
    backgroundColor: '#fff',
    borderColor: 'rbga(0,0,0,0.1)',
    margin: 5,
    height: 150,
    padding: 15,
    shadowColor: '#ccc',
    shadowOffset: {width: 2, height: 2},
    shadowOpacity: 0.5,
    shadowRadius: 3,
  },
});

module.exports = MyScrollableTabView;
