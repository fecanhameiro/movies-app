import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import MAMovieList from './screens/MAMovieList';
import MAMovieDetails from './components/MovieDetails/MAMovieDetails';

const Stack = createNativeStackNavigator();

const MAAppNavigator = () => {
  return (
    <Stack.Navigator initialRouteName="MAMovieList">
      <Stack.Screen name="MAMovieList" options={{title : 'Movies',  headerLargeTitle: true}} component={MAMovieList} />
      <Stack.Screen name="MAMovieDetails" component={MAMovieDetails} />
    </Stack.Navigator>
  );
};

export default MAAppNavigator;
