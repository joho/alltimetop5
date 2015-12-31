import React from 'react';
import ReactDOM from 'react-dom';

import { Router, Route, IndexRoute, hashHistory } from 'react-router';

import Fluxible from 'fluxible';
import { provideContext } from 'fluxible-addons-react';

import AppContainer from './components/AppContainer';

import HomePage from './components/HomePage';
import ShowListPage from './components/ShowListPage';

const routes = (
  <Route path="/" component={AppContainer}>
    <IndexRoute component={HomePage} />
    <Route path="all-time-top-5-star-wars-movies/1234" component={ShowListPage} />
  </Route>
);

const app = new Fluxible({
  component: routes,
  stores: []
});

const context = app.createContext();

const createElement = function (Component, props) {
  props.context = context.getComponentContext();
  return React.createElement(provideContext(Component), props);
}

const router = (
    <Router history={hashHistory} createElement={createElement}>
      {app.getComponent()}
    </Router>
);

ReactDOM.render(
    router,
    document.getElementById('app')
);
