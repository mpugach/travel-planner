
import { startsIn } from 'mpugach-frontend/helpers/starts-in';
import { module, test } from 'qunit';

import moment from 'moment';

module('Unit | Helper | starts in');

// Replace this with your real tests.
test('it works', function(assert) {
  assert.equal(startsIn([moment()]), null);
  assert.equal(startsIn([moment().add(-1, 'day')]), null);
  assert.equal(startsIn([moment().add(1, 'day')]), '(starts in a day)');
  assert.equal(startsIn([moment().add(20, 'day')]), '(starts in 20 days)');
  assert.equal(startsIn([moment().add(30, 'day')]), '(starts in a month)');
  assert.equal(startsIn([moment().add(40, 'day')]), '(starts in a month)');
  assert.equal(startsIn([moment().add(60, 'day')]), '(starts in 2 months)');
});

