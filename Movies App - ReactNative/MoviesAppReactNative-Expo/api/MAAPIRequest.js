import axios from 'axios';

class MAAPIRequest {
  constructor() {
    this.api = axios.create({
      baseURL: 'https://imdb-api.com/en/API'
    });
    this.apiKey = 'k_q0vpw8zr'
  }

  getMostPopularMovies() {
    return this.api.get(`/MostPopularMovies/${this.apiKey}`); 
  }

  getSearchMovies(query) {
    // replace with the correct endpoint
    return this.api.get(`/SearchMovie`); 
  }

  getMovieDetails(id) {
    // replace with the correct endpoint
    return this.api.get(`/Title/${id}`); 
  }

  getMovieRating(id) {
    // replace with the correct endpoint
    return this.api.get(`/Ratings/${id}`); 
  }
}

export default new MAAPIRequest();
