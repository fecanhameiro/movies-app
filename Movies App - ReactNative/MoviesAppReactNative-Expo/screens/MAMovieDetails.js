import React, { useState, useEffect } from 'react';
import { View, Image, StyleSheet, ActivityIndicator } from 'react-native';
import MAMovieDetailsInfoCell from '../components/MovieDetails/MAMovieDetailsInfoCell';
import MAMovieDetailsPlotCell from '../components/MovieDetails/MAMovieDetailsPlotCell';
import MAMovieDetailsFullCastCell from '../components/MovieDetails/MAMovieDetailsFullCastCell';
import MAAPIService from '../api/MAAPIService';

const MAMovieDetails = ({ route, navigation }) => {
    const { movie } = route.params;
    const [movieDetails, setMovieDetails] = useState(null);
    const [fullCast, setFullCast] = useState(null);
    const [isLoading, setIsLoading] = useState(true);
    const [releaseFormattedDate, setReleaseFormattedDate] = useState(null);


    useEffect(() => {

        navigation.setOptions({ title: movie.title });

        const fetchMovieDetails = async () => {
            try {
                const details = await MAAPIService.getMovieDetails(movie.id);

                setMovieDetails(details);

                let date = new Date(details.releaseDate);
                setReleaseFormattedDate(date.toLocaleDateString());

                const directors = details.fullCast.directors.items.map(director => {
                    return {
                        id: director.id,
                        title: details.fullCast.directors.job,
                        name: director.name,
                        image: null
                    }
                });

                const actors = details.fullCast.actors.map(actor => {
                    return {
                        id: actor.id,
                        title: actor.name,
                        name: actor.asCharacter,
                        image: actor.image
                    }
                });

                setFullCast(directors.concat(actors));


            } catch (error) {
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchMovieDetails();
    }, [movie.id, movie.title, navigation]);

    if (isLoading) {
        return <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color="gray" />
        </View>;
    }

    return (
        <View style={styles.container}>
            <Image resizeMode='contain' style={styles.image} source={{ uri: movie.image }} />
            <View style={styles.detailContainer}>
                <MAMovieDetailsInfoCell icon={"tv"} title='Title:' value={movie.title} />
                <MAMovieDetailsInfoCell icon={"calendar"} title='Release Date:' value={releaseFormattedDate} />
                <MAMovieDetailsPlotCell content={movieDetails.plot} />
                <MAMovieDetailsFullCastCell cast={fullCast} />
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
    },
    loadingContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    image: {
        width: '100%',
        height: 320,
    },
    detailContainer: {
        justifyContent: 'space-between',
        alignItems: 'center',
    }
});

export default MAMovieDetails;
