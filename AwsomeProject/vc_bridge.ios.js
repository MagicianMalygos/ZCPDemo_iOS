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


var CalendarManager = require('react-native').NativeModules.CalendarManager;
var date = new Date();
// 普通
CalendarManager.addEvent('zcp', '123');
CalendarManager.addEvent1('date', '999', date.getTime());
CalendarManager.addEvent2('date2', '999', date.toISOString());
CalendarManager.addEvent3('adasd', 'asd', date.getTime());
CalendarManager.addEvent3('aaaa', 'bbbb', date.toISOString());
CalendarManager.addEvent4('', {
  location: 'Hahahaha',
  date: date.getTime(),
});
// 回调
CalendarManager.eventWithCallback((error, events) => {
	alert(events);
});
async function updateEvents() {
  try {
    var events = await CalendarManager.eventWithPromise();
    alert(events);
  } catch (e) {
    console.error(e);
  }
}
updateEvents();


alert(date);


var Index = React.createClass({

  render: function() {
    return (
    	<View>
    	</View>
    );
  },

});

AppRegistry.registerComponent('AwsomeProject', () => Index);
