import Ember from 'ember';

const {
  get,
  Route,
} = Ember;

export default Route.extend({
  model() {
    const today = new Date;

    return get(this, 'store').createRecord('trip', { endDate: today, startDate: today });
  },
});
