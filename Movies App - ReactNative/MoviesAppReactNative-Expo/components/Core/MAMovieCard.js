import React from 'react';
import { View, Text, Image, StyleSheet } from 'react-native';

const MAMovieCard = ({ movie }) => {
    return (
        <View style={styles.card}>
            <Image
                style={styles.image}
                source={{ uri: movie.image }}  
            />
            <Text style={styles.title}>{movie.title}</Text>
        </View>
    );
};

const styles = StyleSheet.create({
    card: {
        flex: 1,
        margin: 8,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#fff',
        borderRadius: 8,
        padding: 0,
        elevation: 3, 
        shadowColor: '#000', 
        shadowOffset: { width: 1, height: 1 }, 
        shadowOpacity: 0.3, 
        shadowRadius: 1 
    },
    image: {
        width: '100%',
        height: 200,
        borderRadius: 5,
        marginBottom: 10
    },
    title: {
        textAlign: 'left',
        fontSize: 14,
        height: 30,
        paddingLeft: 8,
    }
});

export default MAMovieCard;
