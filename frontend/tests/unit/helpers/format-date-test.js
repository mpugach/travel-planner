
import { formatDate } from 'mpugach-frontend/helpers/format-date';
import { module, test } from 'qunit';

module('Unit | Helper | format date');

// Replace this with your real tests.
test('it works', function(assert) {
  const result = formatDate([new Date('2017-04-06')], { format: 'YYYY-DD-MM' });

  assert.equal(result, '2017-06-04');
});

