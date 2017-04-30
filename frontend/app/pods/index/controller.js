import Ember from 'ember';
import DestroyConfirmable from '../../mixins/destroy-confirmable';

const {
  Controller,
} = Ember;

export default Controller.extend(DestroyConfirmable, {
  actions: {
    goToTrip(trip) {
      this.transitionToRoute('trips.edit', trip);
    },
  },
});
