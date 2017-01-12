'use strict'

import React, {Component, PropTypes} from 'react'
import {StyleSheet, View, Text} from 'react-native'

export default class PropsShow extends Component {
  render() {
    var cTextArr = [];
    for (var i in this.props.texts) {
      var item = this.props.texts[i].item;
      var subItems = this.props.texts[i].subItems;
      cTextArr.push(
        <TextItem itemText={item} key={i}/>
      );
      if (subItems) {
        cTextArr.push(
          <View style={{marginTop: 10, marginBottom: 10,}} key={i+1}>
            <View style={styles.container_2}>
              <TextSubItem subItemTexts={subItems}/>
            </View>
          </View>
        );
      }
    }
    return(
      <View style={[styles.container_1, this.props.style]}>
        {cTextArr}
      </View>
    );
  }
}

class TextItem extends Component {
  render() {
    var splitArr = this.props.itemText.split(':');
    var title = '';
    var content = '';
    for (var i = 0; i < splitArr.length; i++) {
      if (i == 0) {
        title = '> ' + splitArr[i];
      } else {
        content += splitArr[i];
      }
    }
    return(
      <View style={styles.textContainer}>
        <Text>
          <Text style={[styles.itemFont, styles.titleText]} numberOfLines={0}>
            {title}
          </Text>
          <Text style={[styles.itemFont, styles.contentText]} numberOfLines={0}>
            {content}
          </Text>
        </Text>
      </View>
    );
  }
}

class TextSubItem extends Component {
  render() {
    var cTexts = [];
    for (var i in this.props.subItemTexts) {
      var title = this.props.subItemTexts[i].title;
      var type = this.props.subItemTexts[i].type;
      var content = this.props.subItemTexts[i].content;
      title = title ? title : '';
      type = type ? type : '';
      content = content ? content : '';

      title = '- ' + title;

      cTexts.push(
        <Text key={i}>
          <Text style={[styles.subItemFont, styles.titleText]} numberOfLines={0}>
            {title + ' '}
          </Text>
          <Text style={[styles.subItemFont, styles.typeText]} numberOfLines={0}>
            {type + ' '}
          </Text>
          <Text style={[styles.subItemFont, styles.contentText]} numberOfLines={0}>
            {content}
          </Text>
        </Text>
      );
    }
    return(
      <View style={styles.textContainer}>
        {cTexts}
      </View>
    );
  }
}

var styles = StyleSheet.create({
  container_1: {
    marginLeft: 15,
    borderStyle: 'solid',
    borderLeftWidth: 5,
    borderLeftColor: 'green',
  },
  container_2: {
    marginLeft: 10,
    borderStyle: 'solid',
    borderLeftWidth: 5,
    borderLeftColor: 'green',
  },
  textContainer: {
    marginLeft: 10,
    marginRight: 15,
  },
  itemFont: {
    lineHeight: 30,
    fontSize: 16,
  },
  subItemFont: {
    lineHeight: 25,
    fontSize: 14,
  },
  titleText: {
    fontWeight: 'bold',
    color: 'red',
  },
  typeText: {
    color: 'green',
  },
  contentText: {
    color: 'black',
  },
});
