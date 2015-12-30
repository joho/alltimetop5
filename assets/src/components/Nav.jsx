import React from 'react';

// import {connectToStores, provideContext} from 'fluxible-addons-react';

class Nav extends React.Component {

  render() {
    return(
      <div>
        <h1>alltimetop5</h1>
        {this.props.children}
      </div>
    );
  }

}

// Nav.contextTypes = {
//   getStore: React.PropTypes.func,
//   executeAction: React.PropTypes.func
// };
//
// export default provideContext(Nav);
//
export default Nav;
