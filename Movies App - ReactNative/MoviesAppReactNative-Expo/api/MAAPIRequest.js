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

  getMoviesBySearch(query) {
    return this.api.get(`/SearchMovie/${this.apiKey}/${encodeURIComponent(query)}`); 
  }

  getMovieDetails(id) {    
    return this.api.get(`/Title/${this.apiKey}/${id}/FullCast`); 
  }

  getMovieRating(id) {
    return this.api.get(`/Ratings/${this.apiKey}/${id}`); 
  }
}

export default new MAAPIRequest();
