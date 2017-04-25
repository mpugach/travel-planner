import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('user-form', 'Integration | Component | user form', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  const expectedText = 'EmailRole';

  this.render(hbs`{{user-form}}`);

  assert.equal(this.$().text().trim().replace(/\s/g,''), expectedText);

  // Template block usage:
  this.render(hbs`
    {{#user-form}}
      template block text
    {{/user-form}}
  `);

  assert.equal(this.$().text().trim().replace(/\s/g,''), expectedText);
});
