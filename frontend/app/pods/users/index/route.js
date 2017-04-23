import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const {
  get,
  Route,
} = Ember;

export default Route.extend(AuthenticatedRouteMixin, {
  model() {
    return get(this, 'store').query('user', {});
  },
});
