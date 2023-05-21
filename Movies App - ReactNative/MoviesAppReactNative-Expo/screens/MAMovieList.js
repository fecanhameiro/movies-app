import React, { useState, useEffect, useRef } from 'react';
import { View, FlatList, ActivityIndicator  } from 'react-native';
import { StyleSheet } from 'react-native';
import MAAPIService from '../api/MAAPIService';
import MAMovieSearchBar from '../components/Core/MAMovieSearchBar';
import MAMovieCard from '../components/Core/MAMovieCard';
import { useNavigation } from '@react-navigation/native';

const MAMovieList = () => {
    const [movies, setMovies] = useState([]);
    const [isLoading, setIsLoading] = useState(false);
    const navigation = useNavigation();
    const [searchText, setSearchText] = useState('');


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

    const fetchMoviesBySearch = async (query) => {
        setIsLoading(true);
        try {
          const data = await MAAPIService.getMoviesBySearch(query);
          console.log(data)
          setMovies(data?.results);
        } catch (error) {
          console.error(error);
        } finally {
          setIsLoading(false);
        }
      };

    useEffect(() => {
        fetchMostPopularMovies();
    }, []);
    
    const renderHeader = () => {
        return (
            <MAMovieSearchBar 
                onSubmitEditing={fetchMoviesBySearch} 
                setSearchText={setSearchText}
                searchText={searchText}
            />
        );
    };
    
      return (
        <View style={styles.container}>
            {isLoading ? (
                <View style={styles.loadingContainer}>
                    <ActivityIndicator size="large" color="gray" />
                </View>
            ) : (
                <FlatList
                    contentInsetAdjustmentBehavior='automatic'
                    style={styles.list}
                    data={movies}
                    numColumns={2}
                    keyExtractor={(item) => item.id}
                    renderItem={({ item }) => (
                        <MAMovieCard movie={item} navigation={navigation} />
                    )}
                    ListHeaderComponent={renderHeader}
                />
            )}
        </View>
    );
    
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: 20,
        paddingHorizontal: 0
    },
    loadingContainer: {
        flex: 1,
        justifyContent: 'center', 
        alignItems: 'center', 
    },
    list: {
        flex: 1
    }
});


export default MAMovieList;
