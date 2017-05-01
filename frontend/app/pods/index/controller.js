import Ember from 'ember';
import DestroyConfirmable from '../../mixins/destroy-confirmable';

const {
  get,
  set,
  observer,
  Controller,
  getProperties,
  run: {
    debounce,
  },
  computed: {
    not,
  },
} = Ember;

export default Controller.extend(DestroyConfirmable, {
  noTrips: not('model.length'),

  termChanged: observer('tripsTerm', function() {
    debounce(this, this.queryTrips, 300);
  }),

  datesChanged: observer('maxEndDate', 'minStartDate', function() {
    this.queryTrips();
  }),

  queryTrips() {
    const keys = ['tripsTerm', 'maxEndDate', 'minStartDate'];
    const filter = getProperties(this, ...keys);

    get(this, 'store')
      .query('trip', this.decamelizeKeys(filter, keys))
      .then(trips => set(this, 'model', trips));
  },

  decamelizeKeys(obj, keys) {
    let newObj = {};

    keys.forEach(key => newObj[key.decamelize()] = obj[key]);

    return newObj;
  },

  actions: {
    goToTrip(trip) {
      this.transitionToRoute('trips.edit', trip);
    },
  },
});
