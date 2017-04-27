import Ember from 'ember';
import ModelEditableMixin from 'mpugach-frontend/mixins/model-editable';
import { module, test } from 'qunit';

module('Unit | Mixin | model editable');

// Replace this with your real tests.
test('it works', function(assert) {
  let ModelEditableObject = Ember.Object.extend(ModelEditableMixin);
  let subject = ModelEditableObject.create();
  assert.ok(subject);
});
