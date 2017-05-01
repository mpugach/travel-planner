import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const {
  get,
  Route,
} = Ember;

export default Route.extend(AuthenticatedRouteMixin, {
  model() {
    const today = new Date;

    return get(this, 'store').createRecord('trip', { endDate: today, startDate: today, comment: '' });
  },
});
