import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';

const MAMovieDetailsInfoCell = ({ icon, title, value }) => {
    return (
        <View style={styles.container} >
            <Icon name={icon} size={24} color="#900" style={styles.icon} />
            <Text style={styles.title}>{title}</Text>
            <Text style={styles.detail}>{value}</Text>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        alignItems: 'center',
        padding: 5,
        marginTop: 10,
        marginStart: 48,
        marginEnd: 48,
    },
    icon: {
        marginRight: 10,
    },
    title: {
        fontSize: 16,
        fontWeight: 'bold',
        marginRight: 10,
    },
    detail: {
        fontSize: 14,
    }
});

export default MAMovieDetailsInfoCell;
