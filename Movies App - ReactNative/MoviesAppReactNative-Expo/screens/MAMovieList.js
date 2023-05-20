import React, { useState, useEffect } from 'react';
import { View, TextInput, Button, FlatList, ActivityIndicator, Text } from 'react-native';
import { StyleSheet } from 'react-native';
import MAAPIService from '../api/MAAPIService';
import MASearchBar from '../components/Core/MASearchBar';
import MAMovieCard from '../components/Core/MAMovieCard';

const MAMovieList = () => {
  const [query, setQuery] = useState('');
  const [movies, setMovies] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  const fetchMostPopularMovies = async () => {
    setIsLoading(true);
    try {
     
      const data = await MAAPIService.getMostPopularMovies();
     
      setMovies(data?.items);
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchMostPopularMovies();
  }, []);

  return (
    <View style={styles.container}>
        <MASearchBar
            query={query}
            onQueryChange={setQuery}
            onSearch={fetchMostPopularMovies}
        />
        {isLoading ? (
            <ActivityIndicator />
        ) : (
            <FlatList
                style={styles.list}
                data={movies}
                numColumns={2}  
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => (
                    <MAMovieCard movie={item} />  
                )}
            />
        )}
    </View>
);
};

const styles = StyleSheet.create({
container: {
    flex: 1,
    paddingTop: 20,  // Adicione um pouco de espaço no topo
    paddingHorizontal: 0
},
list: {
    flex: 1
}
});

export default MAMovieList;
