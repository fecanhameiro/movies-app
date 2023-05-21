import MAAPIRequest from './MAAPIRequest';

class MAAPIService {
  async getMoviesBySearch(query) {
    try {
      const response = await MAAPIRequest.getMoviesBySearch(query);
      return response.data;
    } catch (error) {
      throw error;
    }
  }

  async getMostPopularMovies() {
    try {
      const response = await MAAPIRequest.getMostPopularMovies();
      return response.data;
    } catch (error) {
      throw error;
    }
  }

  async getMovieDetails(id) {
    try {
      const response = await MAAPIRequest.getMovieDetails(id);
      return response.data;
    } catch (error) {
      throw error;
    }
  }

  async getMovieRating(id) {
    try {
      const response = await MAAPIRequest.getMovieRating(id);
      return response.data;
    } catch (error) {
      throw error;
    }
  }
}

export default new MAAPIService();
