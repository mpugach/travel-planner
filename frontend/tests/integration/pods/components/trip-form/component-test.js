import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('trip-form', 'Integration | Component | trip form', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  const content = 'Destination';

  this.render(hbs`{{trip-form}}`);

  assert.equal(this.$().text().trim(), content);

  // Template block usage:
  this.render(hbs`
    {{#trip-form}}
      template block text
    {{/trip-form}}
  `);

  assert.equal(this.$().text().trim(), content);
});
