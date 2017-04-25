import React from 'react';
import { Link } from 'react-router-dom';
import Relay, { graphql } from 'react-relay';

class Home extends React.Component {
    render() {
        const users = this.props.users.map((user) =>
            <li>
                <Link to={`@#{user.username}`}>
                    {user.username}
                </Link>
            </li>
        );

    
        return (
            <div>
                <h2>Home</h2>
                <ul>
                    {users}
                </ul>
            </div>
        )
    }
}

Home = Relay.createFragmentContainer(
    Home,
    graphql`
        fragment Home_User on User {
            username
        }
    `,
);

export default Home;