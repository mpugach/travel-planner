import Ember from 'ember';
import DataAdapterMixinMixin from 'mpugach-frontend/mixins/data-adapter-mixin';
import { module, test } from 'qunit';

module('Unit | Mixin | data adapter mixin');

// Replace this with your real tests.
test('it works', function(assert) {
  let DataAdapterMixinObject = Ember.Object.extend(DataAdapterMixinMixin);
  let subject = DataAdapterMixinObject.create();
  assert.ok(subject);
});
