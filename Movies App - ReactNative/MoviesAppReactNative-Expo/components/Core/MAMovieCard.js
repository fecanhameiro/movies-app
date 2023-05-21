import React from 'react';
import { View, Text, Image, StyleSheet, TouchableOpacity } from 'react-native';

const MAMovieCard = ({ movie, navigation }) => {
    return (
        <TouchableOpacity style={styles.touchable}  onPress={() => navigation.navigate('MAMovieDetails', { movie })}>
            <View style={styles.card}>
                <Image
                    style={styles.image}
                    source={{ uri: movie.image }}
                />
                <Text style={styles.title} numberOfLines={2}>{movie.title}</Text>
                <Text style={styles.rating}>IMDB: {movie.imDbRating}</Text>
            </View>
        </TouchableOpacity>
    )
};

const styles = StyleSheet.create({
    touchable: {
        flex: 1,
        margin: 8,
        backgroundColor: '#fff',
        borderRadius: 8,
        elevation: 3,
        shadowColor: '#000',
        shadowOffset: { width: 1, height: 1 },
        shadowOpacity: 0.3,
        shadowRadius: 1,
        height: 300,
 
    },
    card: {
        flex: 1,
        justifyContent: 'flex-start',
        alignItems: 'left',
        padding: 0,
    },
    image: {
        width: '100%',
        height: 220,
        borderRadius: 5,
        marginBottom: 10
    },
    title: {
        textAlign: 'left',
        fontSize: 14,
        fontWeight: '600',
        paddingLeft: 8,
    },
    rating: {
        textAlign: 'left',
        fontSize: 12,
        fontWeight: '400',
        position: 'absolute',
        paddingLeft: 8,
        bottom: 12
    }
});

export default MAMovieCard;
