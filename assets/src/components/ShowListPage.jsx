import React from 'react';
import { contextTypes } from 'fluxible';

import { Link } from 'react-router';

class ShowListPage extends React.Component {
  render() {
    return(
        <div>
          <p>Hello, I am a list</p>
          <ol>
            <li>Empire Strikes Back</li>
            <li>A New Hope</li>
            <li>The Force Awakens</li>
            <li>Return of the Jedi</li>
            <li>Revenge of the Sith</li>
          </ol>
          <Link to="/">Home</Link>
        </div>
    );
  }
}

ShowListPage.contextTypes = contextTypes;

export default ShowListPage;
