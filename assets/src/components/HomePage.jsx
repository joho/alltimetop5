import React from 'react';
import { contextTypes } from 'fluxible';
import { Link } from 'react-router';

class HomePage extends React.Component {
  render() {
    return(
        <div>
          <p>Hello, I am home</p>
          <p>I have some context: {this.context.toString()}</p>
          <Link to="/all-time-top-5-star-wars-movies/1234">All Time Top 5 Star Wars Movies</Link>
        </div>
    );
  }
}

HomePage.contextTypes = contextTypes;

export default HomePage;
