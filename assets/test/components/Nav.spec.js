import React from 'react';
import { createRenderer } from 'react-addons-test-utils';

import Nav from 'components/Nav';

describe('Nav', () => {
  it('has a h1 with the site name', () => {
    let renderer = createRenderer();
    renderer.render(<Nav />);

    let actualElement = renderer.getRenderOutput();
    let expectedElement = <h1>alltimetop5</h1>;

    expect(actualElement).toEqualJSX(expectedElement);
  });
});
