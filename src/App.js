import React from 'react';

import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';

import Home from './pages/Home';
import Profile from './pages/Profile';
import List from './pages/List';

import './App.css';

const FourOhFour = () => (
  <div>
    <h1>404</h1>
  </div>
)

const App = () => (
  <Router>
    <div>
      <Switch>
        <Route exact path="/" component={Home} />
        <Route exact path="/@:userName" component={Profile} />
        <Route exact path="/@:userName/:listSlug" component={List} />
        <Route component={FourOhFour} />
      </Switch>
    </div>
  </Router>
)

export default App;
