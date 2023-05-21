import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { NavigationContainer } from '@react-navigation/native';
import MAAppNavigator from './navigation/MAAppNavigator';
import Icon from 'react-native-vector-icons/FontAwesome';

const Tab = createBottomTabNavigator();

function MyTabs() {
  return (
    <Tab.Navigator>
      <Tab.Screen 
        name="Movies" 
        component={MAAppNavigator}
        
        options={{
          headerShown: false, 
          tabBarLabel: 'Movies',
          tabBarIcon: ({ color, size }) => (
            <Icon name="film" color={color} size={size} /> 
          ),
        }} 
      />
    </Tab.Navigator>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <MyTabs />
    </NavigationContainer>
  );
}
