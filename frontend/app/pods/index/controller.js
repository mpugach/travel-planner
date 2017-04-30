import Ember from 'ember';

const {
  Controller,
} = Ember;

export default Controller.extend({
  actions: {
    goToTrip(trip) {
      this.transitionToRoute('trips.edit', trip);
    },
  },
});
