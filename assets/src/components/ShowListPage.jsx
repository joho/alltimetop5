import React from 'react';
import { contextTypes } from 'fluxible';

import fetchList from '../actions/fetchList';

import { Link } from 'react-router';

class ShowListPage extends React.Component {
  componentDidMount() {
    // Set timeout to make sure all dispatches have finished before
    // further actions are fired
    setTimeout(() => {
        // TODO figure out why the contextTypes thingy isn't working as i expected.
        if (this.props.list === null) {
            this.context.executeAction(fetchList);
        }
    }, 0);
  }

  renderListEntry(entry) {
    return <li>{entry}</li>;
  }

  render() {
    return(
        <div>
          <p>Hello, I am a list</p>
          <ol>
            {this.props.list.map(this.renderListEntry)}
          </ol>
          <Link to="/">Home</Link>
        </div>
    );
  }
}

ShowListPage.contextTypes = {
    executeAction: React.PropTypes.func.isRequired,
    router: React.PropTypes.func.isRequired
};

export default ShowListPage;
