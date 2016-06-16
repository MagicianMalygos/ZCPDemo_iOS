'use strict';
var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  View,
  Text,
  Image,
  ListView,
} = React;

var API_KEY = '7waqfqbprs7pajbz28mqf6vz';
var API_URL = 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json';
var PAGE_SIZE = 25;
var PARAMS = '?apikey=' + API_KEY + '&page_limit=' + PAGE_SIZE;
var REQUEST_URL = API_URL + PARAMS; // 如果Network reqeust failed的情况，该如何处理

var MoviesList = React.createClass({
  // 初始化状态，信息可从this.state中获取到
  getInitialState: function() {
    return ({
      moviesData: new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
      }),
      loading: true,
    });
  },
  // 渲染视图
  render: function() {
    if (this.state.loading) {
      return (
        <View style={styles.container}>
          <Text>Loading...</Text>
        </View>
      );
    }
    alert('??:'+this.state.moviesData.movies);
    return (
      <ListView
        style={styles.listView}
        dataSource={this.state.moviesData} 
        renderRow={(movie) => {
          return (
            <View style={styles.container}>
              <Image source={{uri: movie.posters.thumbnail}} style={styles.thumbnail}></Image>
              <View style={styles.rightContainer}>
                <Text style={styles.title}>{movie.title}</Text>
                <Text style={styles.year}>{movie.year}</Text>
              </View>
            </View>
          );
        }}/>
    );
  },
  // 渲染视图完成后
  componentDidMount: function() {
    fetch(REQUEST_URL)
    .then((response) => response.json())
    .then((responseData) => {

      // setState会重新触发一次重新渲染
      if (responseData.movies) {
        this.setState({
          moviesData: this.state.moviesData.cloneWithRows(responseData.movies),
          loading: false,
        });
      }
    })
    .done();
  },
});


var styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  rightContainer: {
    flex: 1,
  },
  title: {
    fontSize: 20,
    marginBottom: 8,
    textAlign: 'center',
  },
  year: {
    textAlign: 'center',
  },
  thumbnail: {
    width: 53,
    height: 81,
  },
  listView: {
    marginTop: 20,
    backgroundColor: '#F5FCFF',
  },
});

AppRegistry.registerComponent('AwsomeProject', () => MoviesList);
