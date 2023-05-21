import React from 'react';
import { View, Text, FlatList, StyleSheet, Image } from 'react-native';

const MAMovieDetailsFullCastCell = ({ cast }) => {
    const renderItem = ({ item }) => (
        <View style={styles.card}>
        <Image style={styles.image} source={item.image ? { uri: item.image } : require('../../assets/director.png')} />
        <View style={styles.textContainer}>
            <Text style={styles.actorName} numberOfLines={2}>{item.title}</Text>
            <Text style={styles.actorRole} numberOfLines={2}>{item.name}</Text>
        </View>
    </View>
    );

    return (
        <View style={styles.container}>
            <FlatList
                horizontal
                data={cast}
                keyExtractor={(item) => item.id}
                renderItem={renderItem}
            />
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        padding: 10,
    },
    title: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 10,
    },
    card: {
        flexDirection: 'row',
        justifyContent: 'flex-start',
        marginRight: 10,
        backgroundColor: '#f2f2f2',
        borderRadius: 5,
        elevation: 3,
        shadowColor: '#000',
        shadowOffset: { width: 1, height: 1 },
        shadowOpacity: 0.3,
        shadowRadius: 1,
        width: 300,
        height: 130,
    },
    image: {
        width: 120,
        height: 130,
        borderTopLeftRadius: 5,
        borderBottomLeftRadius: 5,
    },
    textContainer: {
        flexDirection: 'column',
        paddingLeft: 8,
        flexShrink: 1,
    },
    actorName: {
        fontSize: 22,
        marginTop: 10,
        flexShrink: 1,
        height: 64
    },
    actorRole: {
        fontSize: 18,
        flexShrink: 1,
    },
});

export default MAMovieDetailsFullCastCell;
