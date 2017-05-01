import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('user-trips', 'Integration | Component | user trips', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  const content = 'MindateFiltertripsMaxdateadd_locationpicture_as_pdfNotripsfound...';

  this.render(hbs`{{user-trips}}`);

  assert.equal(this.$().text().trim().replace(/\s/g,''), content);

  // Template block usage:
  this.render(hbs`
    {{#user-trips}}
      template block text
    {{/user-trips}}
  `);

  assert.equal(this.$().text().trim().replace(/\s/g,''), content);
});
