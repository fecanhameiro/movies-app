import React from 'react';
import MAMovieCard from './MAMovieCard';
import './MACore.css';

const MAMoviesCardList = ({ movies }) => {
    return (
        <div className="ma-movies-list">
            {movies.map((movie, index) => (
                <MAMovieCard key={index} movie={movie} />
            ))}
        </div>
    );
};

export default MAMoviesCardList;
