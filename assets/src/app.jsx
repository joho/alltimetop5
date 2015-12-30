import React from 'react';
import ReactDOM from 'react-dom';

import { Router, Route, IndexRoute, hashHistory } from 'react-router';

// import Fluxible from 'fluxible';
// import { FluxibleComponent } from 'fluxible-addons-react';

import Nav from './components/Nav';

import HomePage from './components/HomePage';
import ShowListPage from './components/ShowListPage';

const router = (
    <Router history={hashHistory}>
      <Route path="/" component={Nav}>
        <IndexRoute component={HomePage} />
        <Route path="all-time-top-5-star-wars-movies/1234" component={ShowListPage} />
      </Route>
    </Router>
);

// const app = new Fluxible({
//   component: router,
//   stores: []
// });
//
// const context = app.createContext();

ReactDOM.render(router, document.getElementById('app'));
