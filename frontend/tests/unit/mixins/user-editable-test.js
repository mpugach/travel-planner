import Ember from 'ember';
import UserEditableMixin from 'mpugach-frontend/mixins/user-editable';
import { module, test } from 'qunit';

module('Unit | Mixin | user editable');

// Replace this with your real tests.
test('it works', function(assert) {
  let UserEditableObject = Ember.Object.extend(UserEditableMixin);
  let subject = UserEditableObject.create();
  assert.ok(subject);
});
