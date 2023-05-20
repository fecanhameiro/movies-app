import MAAPIRequest from './MAAPIRequest';

class MAAPIService {
  async getSearchMovies(query) {
    try {
      const response = await MAAPIRequest.getSearchMovies(query);
      return response.data; // replace with the correct property path to the data
    } catch (error) {
      throw error;
    }
  }

  async getMostPopularMovies() {
    try {
      const response = await MAAPIRequest.getMostPopularMovies();
      return response.data; // replace with the correct property path to the data
    } catch (error) {
      throw error;
    }
  }

  async getMovieDetails(id) {
    try {
      const response = await MAAPIRequest.getMovieDetails(id);
      return response.data; // replace with the correct property path to the data
    } catch (error) {
      throw error;
    }
  }
}

export default new MAAPIService();
