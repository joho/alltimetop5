import React from 'react';
import { Link } from 'react-router';

export default class HomePage extends React.Component {
  render() {
    return(
        <div>
          <p>Hello, I am home</p>
          <Link to="/all-time-top-5-star-wars-movies/1234">All Time Top 5 Star Wars Movies</Link>
        </div>
    );
  }
}
