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
  model(params) {
    const store = get(this, 'store');

    return hash({
      user: store.findRecord('user', params.userId),
      trips: store.query('trip', { user_id: params.userId }),
    });
  },
});
