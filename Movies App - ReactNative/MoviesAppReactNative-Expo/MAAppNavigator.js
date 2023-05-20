import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import MAMovieList from './screens/MAMovieList';

const Stack = createStackNavigator();

const MAAppNavigator = () => {
  return (
    <Stack.Navigator initialRouteName="MAMovieList">
      <Stack.Screen name="MAMovieList" component={MAMovieList} />
    </Stack.Navigator>
  );
};

export default MAAppNavigator;
