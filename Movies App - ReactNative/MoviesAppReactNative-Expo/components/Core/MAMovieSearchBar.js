import { React, useState } from 'react';
import { StyleSheet } from 'react-native';
import { SearchBar } from 'react-native-elements';

const MAMovieSearchBar = ({ onSubmitEditing, setSearchText, searchText }) => {
  const handleChangeText = (text) => {
    setSearchText(text);
  };

  return (
    <SearchBar
      placeholder="Search for movies"
      onChangeText={handleChangeText}
      value={searchText}
      onSubmitEditing={() => onSubmitEditing(searchText)}
      platform="ios"
      containerStyle={styles.container}
      inputStyle={styles.input}
      cancelButtonTitle="Cancel"
    />
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'white',
    borderBottomColor: 'transparent',
    borderTopColor: 'transparent'
  },
  input: {
    backgroundColor: '#EDEDED'
  }
});

export default MAMovieSearchBar;
