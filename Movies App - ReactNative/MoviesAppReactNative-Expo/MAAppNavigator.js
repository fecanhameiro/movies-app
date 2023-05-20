import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import MAMovieList from './screens/MAMovieList';
import MAMovieDetails from './components/MovieDetails/MAMovieDetails';

const Stack = createStackNavigator();

const MAAppNavigator = () => {
  return (
    <Stack.Navigator initialRouteName="MAMovieList">
      <Stack.Screen name="MAMovieList" component={MAMovieList} />
      <Stack.Screen name="MAMovieDetails" component={MAMovieDetails} />
    </Stack.Navigator>
  );
};

export default MAAppNavigator;
