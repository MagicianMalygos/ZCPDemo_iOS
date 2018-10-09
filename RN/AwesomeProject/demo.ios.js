import React, {Component} from 'react'
import {
  AppRegistry,
  StyleSheet,
  ListView,
  Text,
  View,
  Navigator
} from 'react-native';

import MyScene from './MyScene'

// 组件
class ListViewBasics extends Component {
  constructor (props) {
    super(props);
    const ds = new ListView.DataSource({rowHasChanged:(r1, r2) => r1 !== r2});
    this.state = {
      dataSource: ds.cloneWithRows([
        'AA', 'BB', 'CC', 'DD', 'EE', 'FF'
      ])
    };
  }
  render() {
    return(
      <Navigator
        style={{paddingTop: 22}}
        initialRoute={{title: 'My Initial Scene', index: 0}}
        renderScene={(route, navigator) => {
          return (
            <MyScene
              title={route.title}
              onForward={()=>{
                const nextIndex = route.index + 1;
                navigator.push({
                  title: 'Scene' + nextIndex,
                  index: nextIndex,
                });
              }}
              onBack={()=>{
                if (route.index > 0) {
                  navigator.pop();
                }
              }}
            />
          )
        }}
      />
    );
  }
}

// 样式
const styles = StyleSheet.create({
  bigblue: {
    color: 'blue',
    fontWeight: 'bold',
    fontSize: 30,
  },
  red: {
    color: 'red',
    backgroundColor: 'green',
  }
});


// 注册根组件，只能注册一个，‘’中的内容必须跟项目名一致
AppRegistry.registerComponent('AwesomeProject', () => ListViewBasics);
