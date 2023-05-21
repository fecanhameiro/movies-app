import { NavigationContainer } from '@react-navigation/native';
import MAAppNavigator from './navigation/MAAppNavigator';

export default function App() {

  return (
    <NavigationContainer>
      <MAAppNavigator />
    </NavigationContainer>
  );
}