'use strict';
var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  View,
  Text,
  NavigatorIOS,
  TouchableHighlight,
} = React;

var showView = React.createClass({
	render: function() {

		var title = 'push';

		return (
			<View style={{marginTop: 100}}>
				{this._renderRow(title, () => {
					this.props.navigator.push({
						title: 'Push View',
						component: pushView,
						backButtonTitle: 'Back',
					});
				})}
			</View>
		);
	},

	_renderRow: function(title: string, onPress: Function) {
		return (
			<View>
				<TouchableHighlight onPress={onPress}>
					<View>
						<Text>{title}</Text>
					</View>
				</TouchableHighlight>
			</View>
		);
	},
});



var pushView = React.createClass({

	render: function() {

		var title = 'pop';
		
		return (
			<View>
				{
					this._renderRow(title, () => {
						this.props.navigator.pop();
					})
				}
			</View>
		);
	},

	_renderRow: function(title: string, onPress: Function) {
		return (
			<View style={{marginTop: 100}}>
				<TouchableHighlight onPress={onPress}>
					<View>
						<Text>{title}</Text>
					</View>
				</TouchableHighlight>
			</View>
		);
	},
});

var Index = React.createClass({

	_handleNextButtonPress: function() {
	  	this.refs.nav.navigator.push({
	  		component: pushView,
	  		title: 'Push from right navigator button',
	  	});
  	},

  render: function() {
    return (
      <NavigatorIOS style={{flex:1}} 
      barTintColor={'red'} 
      tintColot={'green'}
      titleTextColor={'black'}
      navigationBarHidden={false}
      shadowHidden={true}
      translucent={true}
      initialRoute={{
      	title: '首页', 
      	component: showView,
      	backButtonTitle: '返回',
      	leftButtonTitle: '左',
      	rightButtonTitle: '右',
      	onRightButtonPress: this._handleNextButtonPress,
      }}/>
    );
  },

});

AppRegistry.registerComponent('AwsomeProject', () => Index);
