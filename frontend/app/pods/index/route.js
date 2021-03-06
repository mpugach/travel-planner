import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const {
  get,
  Route,
  RSVP: {
    hash,
  },
} = Ember;

export default Route.extend(AuthenticatedRouteMixin, {
  model() {
    return hash({
      trips: get(this, 'store').query('trip', {}),
    });
  },
});
