import React from 'react';
import { Link } from 'react-router-dom';

const Profile = ({match}) => (
  <div>
    <h2>Profile for {match.params.userName}</h2>
    <Link to={`${match.url}/top-five-js-frameworks`}>
      All time top 5 js frameworks
    </Link>

    <br />

    <Link to="/">Home</Link>
  </div>
)

export default Profile;