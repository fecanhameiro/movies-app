import React from 'react';
import { View, TextInput, Button, StyleSheet } from 'react-native';

const MASearchBar = ({ query, onQueryChange, onSearch }) => {
  return (
    <View style={styles.container}>
      <TextInput
        value={query}
        onChangeText={onQueryChange}
        style={styles.input}
        placeholder="Search for movies"
      />
      <Button onPress={onSearch} title="Search" />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  input: {
    flex: 1,
    borderColor: '#ccc',
    borderWidth: 1,
    marginRight: 10,
    padding: 5,
  },
});

export default MASearchBar;
