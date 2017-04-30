import Ember from 'ember';
import DestroyConfirmableMixin from 'mpugach-frontend/mixins/destroy-confirmable';
import { module, test } from 'qunit';

module('Unit | Mixin | destroy confirmable');

// Replace this with your real tests.
test('it works', function(assert) {
  let DestroyConfirmableObject = Ember.Object.extend(DestroyConfirmableMixin);
  let subject = DestroyConfirmableObject.create();
  assert.ok(subject);
});
