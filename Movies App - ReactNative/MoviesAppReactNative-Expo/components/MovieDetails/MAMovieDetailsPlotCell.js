import React from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';

const MAMovieDetailsPlotCell = ({  content }) => {
    return (
        <View style={styles.container}>
        <ScrollView style={styles.scrollView}>
            <Text style={styles.content}>{content}</Text>
        </ScrollView>
    </View>
    );
};

const styles = StyleSheet.create({
    container: {
        padding: 18,
        height: 120,
    },
    title: {
        fontSize: 18,
        fontWeight: 'bold',
        marginBottom: 10,
    },
    scrollView: {
        maxHeight: 300, 
    },
    content: {
        fontSize: 14,
    }
});

export default MAMovieDetailsPlotCell;
