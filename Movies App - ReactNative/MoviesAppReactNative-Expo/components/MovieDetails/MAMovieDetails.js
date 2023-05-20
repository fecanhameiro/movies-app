import React from 'react';
import { View, Text, Image, StyleSheet } from 'react-native';
import MAMovieDetailsInfoCell from './MAMovieDetailsInfoCell';


const MAMovieDetails = ({ route }) => {
    const { movie } = route.params;

    return (
        <View style={styles.container}>
            <Image resizeMode='contain' style={styles.image} source={{ uri: movie.image }} />
            <View style={styles.detailContainer}>
                <MAMovieDetailsInfoCell icon={"tv"} title='Title:' value={movie.title} />
                <MAMovieDetailsInfoCell icon={"calendar"} title='Release Date:' value={movie.release_date} />
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
    },
    image: {
        width: '100%',
        height: 300,
    },
    detailContainer: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingHorizontal: 10,
    }
});

export default MAMovieDetails;
