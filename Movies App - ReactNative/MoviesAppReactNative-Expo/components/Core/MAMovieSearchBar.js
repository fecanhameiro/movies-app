import { React, useState } from 'react';
import { StyleSheet } from 'react-native';
import { SearchBar } from 'react-native-elements';

const MAMovieSearchBar = ({ onSubmitEditing }) => {
  const [searchText, setSearchText] = useState('');

  return (
    <SearchBar
      placeholder="Search for your favorite movie..."
      onChangeText={(text) => setSearchText(text)}
      value={searchText}
      onSubmitEditing={() => onSubmitEditing(searchText)}
      platform="ios"
      containerStyle={styles.container}
      inputStyle={styles.input}
      cancelButtonTitle="Cancel"
      keyboardType='web-search'
    />
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#EDEDED',
    borderBottomColor: 'transparent',
    borderTopColor: 'transparent'
  },
  input: {
    backgroundColor: '#EDEDED'
  }
});

export default MAMovieSearchBar;
