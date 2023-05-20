import React from 'react';
import { View, Text, StyleSheet, Image } from 'react-native';
import Icon from 'react-native-vector-icons/FontAwesome';

const MAMovieDetailsInfoCell = ({ icon, title, value }) => {
    return (
        <View style={styles.icon}>
            <Icon style={styles.title} name={icon} size={24} color="#900" />
            <Text style={styles.title}>{title}</Text>
            <Text style={styles.detail}>{value}</Text>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        alignItems: 'center',
        padding: 10,
    },
    icon: {
        width: 20,
        height: 20,
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
