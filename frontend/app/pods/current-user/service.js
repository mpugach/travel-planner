import Ember from 'ember';

const {
  get,
  set,
  Service,
  inject: { service },
} = Ember;

export default Service.extend({
  data: {},

  store: service(),

  load() {
    if (get(this, 'session.isAuthenticated')) {
      return get(this, 'store').find('user', 'me').then(user => set(this, 'data', user));
    }
  }
});
