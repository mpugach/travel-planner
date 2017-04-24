import Ember from 'ember';

const {
  get,
  Controller,
  getProperties,
  inject: {
    service,
  },
} = Ember;

export default Controller.extend({
  session: service(),

  actions: {
    authenticate() {
      const { email, password } = getProperties(this, 'email', 'password');

      get(this, 'session')
        .authenticate('authenticator:devise', email, password)
        .catch(reason => {
          if (reason.errors) {
            reason.errors.forEach(error => this.toast.error(error));
          }
        });
    },
  },
});
