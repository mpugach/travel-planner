import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

const {
  get,
  Route,
  inject: {
    service,
  },
} = Ember;

export default Route.extend(ApplicationRouteMixin, {
  currentUser: service(),

  beforeModel() {
    this._loadCurrentUser();
  },

  sessionAuthenticated() {
    this._super(...arguments);
    this._loadCurrentUser();
  },

  _loadCurrentUser() {
    get(this, 'currentUser').load();
  },
});
