import React from 'react';
import { Link } from 'react-router';

import {contextTypes} from 'fluxible';
// import {connectToStores, provideContext} from 'fluxible-addons-react';

class AppContainer extends React.Component {

    render() {
        return(
                <div>
                <h1>alltimetop5</h1>
                <nav>
                    <Link to="/new">Create New</Link>
                </nav>
                {this.props.children}
                </div>
              );
    }

}

AppContainer.contextTypes = contextTypes;

export default AppContainer;
