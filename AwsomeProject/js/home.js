'use strict';

/*
import React from 'React';    导入的是类
var React = require('React'); 得到的是一个对象
*/
var React = require('React');
var {
  Component,PropTypes,
} = React;
var ReactNative = require('react-native');
var {
  AppRegistry, StyleSheet, ListView, Text, View,
  NavigatorIOS, TouchableHighlight, PixelRatio
} = ReactNative;

var navinfo = require('./navinfo.js');
import Demo1 from './custom_component/title';

export default class HomeView extends Component {
  render() {
    return(
      <NavigatorIOS
        style={{flex: 1}}
        initialRoute={{
          index: 0,
          display: true,
          title: 'React-Native',
          rightButtonTitle: 'Add',
          component: DemoListView,
          backButtonTitle: 'Back',
          barTintColor: 'white',
          translucent: false,
        }}
        renderScene={(route, navigator) => {
          return <route.component navigator={navigator} title={route.title} index={route.index} />
        }}
      />
    );
  }
}

export class DemoListView extends Component {
  static propTypes = {
    navigator: PropTypes.object.isRequired,
  }
  constructor(props, context) {
    super(props, context);

    // 数据源
    var datasource = new ListView.DataSource({
      rowHasChanged: (r1, r2)=>{r1 !== r2},
      sectionHeaderHasChanged: (s1, s2)=>{s1 !== s2},
    });
    this.state = {
      dataSource: datasource.cloneWithRowsAndSections(navinfo)
    };
  }

  _jumpToDemo(data) {
    this.props.navigator.push({
      title: data.title,
      index: data.index,
      display: !data.hideNav,
      component: data.component,
      backButtonTitle: data.backButtonTitle,
      barTintColor: 'white',
      translucent: false,
      passProps: {
        info: data.title,
        index: data.index,
      },
    });
  }
  _renderRow(rowData, sectionId, rowId) {
    return(
      <TouchableHighlight
        style={styles.row}
        onPress={()=>this._jumpToDemo(rowData)
        }>
        <Text style={styles.text}>{rowData.title}</Text>
      </TouchableHighlight>
    );
  }
  _renderSectionHeader(sectionData, sectionId) {
    return(
      <Text style={styles.section}>{sectionId}</Text>
    );
  }
  render() {
    return(
      <ListView
        style={styles.listview}
        dataSource={this.state.dataSource}
        renderSectionHeader={(sectionData, sectionId)=>
          this._renderSectionHeader(sectionData, sectionId)
        }
        renderRow={(rowData, sectionId, rowId)=>
          this._renderRow(rowData, sectionId, rowId)
        }
      />
    );
  }
}

var styles = StyleSheet.create({
  listview: {
    flex: 1,
    backgroundColor: 'white',
    marginBottom: 64,
  },
  section: {
    height: 30,
    backgroundColor: '#f4f4f4',
    fontSize: 12,
    paddingTop: 10,
    paddingLeft: 15,
    paddingRight: 15,
  },
  row: {
    height: 40,
    borderStyle: 'solid',
    borderBottomWidth: 1 / PixelRatio.get(),
    borderBottomColor: '#dfdfdf',
  },
  text: {
    flex: 1,
    fontSize: 14,
    height: 15,
    marginTop: 12.5,
    marginLeft: 15,
    marginRight: 15,
  }
});

AppRegistry.registerComponent('AwesomeProject', () => HomeView);
