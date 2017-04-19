import React from 'react';
import { Link } from 'react-router-dom';

const List = ({ match }) => (
  <div>
    <h2>all time top 5 js frameworks</h2>
    By <Link to={`/@${match.params.userName}`}>{match.params.userName}</Link>
    <ol>
      <li>react</li>
      <li>react</li>
      <li>react</li>
      <li>react</li>
      <li>react</li>
    </ol>

    <br />
    <Link to="/">Home</Link>
  </div>
)

export default List;