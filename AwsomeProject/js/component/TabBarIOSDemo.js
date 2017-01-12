'use strict'

import React,{Component, PropTypes} from 'react'
import {
  View,
  Text,
  Image,
  TabBarIOS,
  ScrollView,
  StyleSheet,
} from 'react-native'

import PropsShow from '../custom_component/PropsShow'
import Title from '../custom_component/title'

var TabBarIOSDemo = React.createClass({
  getInitialState() {
    return({
      tab: 'message',
    });
  },
  _selectTab(tabName) {
    this.setState({
      tab : tabName,
    });
  },
  render() {
    return(
      <TabBarIOS style={{flex: 1, marginBottom: 64}}
        barTintColor='#ff8447'
        tintColor='white'
        translucent={true}>
        <TabBarIOS.Item
          title='消息'
          icon={require('image!message')}
          onPress={()=>this._selectTab('message')}
          selected={this.state.tab === 'message'}
          badge={20}>
          <ScrollView>
            <Title
              title={'TabBarIOS'}
              height={50}
              textMarginLeft={15}
              textMarginRight={15}
              p={4}
              backgroundColor={'#fff'}
              fontColor={'red'}/>
            <PropsShow texts={[
              {item: 'barTintColor: tab栏的背景颜色',},
              {item: 'tintColor: tab被选中时的颜色',},
              {item: 'translucent: tab栏是否透明',},
            ]}/>
            <Title
              title={'TabBarIOS.Item'}
              height={50}
              textMarginLeft={15}
              textMarginRight={15}
              p={4}
              backgroundColor={'#fff'}
              fontColor={'red'}/>
            <PropsShow texts={[
              {item: 'badge: 红色角标数字',},
              {item: 'icon: tab自定义图标。如果定义了systemIcon，则icon被忽略',},
              {item: 'selectedIcon: 选中状态图标。如果定义了systemIcon，则selectedIcon被忽略',},
              {item: 'onPress: 点击事件',},
              {item: 'selected: 是否选中某个tab，显示其子视图',},
              {item: 'systemIcon: 系统图标。bookmarks、contacts、downloads、favorites、featured、history、more、most-recent、most-viewed、recents、search、top-rated',},
              {item: 'title: 标题。如果定义了systemIcon，则title被忽略',},
            ]}/>
          </ScrollView>
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title='联系人'
          icon={require('image!phone')}
          onPress={()=>this._selectTab('phonelist')}
          selected={this.state.tab === 'phonelist'}>
          <ScrollView>
          </ScrollView>
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title='动态'
          icon={require('image!star')}
          onPress={()=>this._selectTab('star')}
          selected={this.state.tab === 'star'}>
          <ScrollView>
          </ScrollView>
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  },
});

module.exports = TabBarIOSDemo;
