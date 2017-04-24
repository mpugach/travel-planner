import Ember from 'ember';

const {
  Controller,
  getProperties,
  inject: {
    service,
  },
} = Ember;

export default Controller.extend({
  ajax: service(),
  session: service(),

  actions: {
    register() {
      const { ajax, model, session } = getProperties(this, 'ajax', 'model', 'session');
      const { email, password } = getProperties(model, 'email', 'password');

      ajax
        .post('/auth', { data: { email, password } })
        .then(() => session.authenticate('authenticator:devise', email, password));
    },
  },
});
