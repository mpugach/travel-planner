import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('destroy-confirmation', 'Integration | Component | destroy confirmation', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{destroy-confirmation}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#destroy-confirmation}}
      template block text
    {{/destroy-confirmation}}
  `);

  assert.equal(this.$().text().trim(), '');
});
